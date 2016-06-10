class CommandesController < ApplicationController
  before_filter :message_user
  before_filter :login_required
  filter_access_to :all
  before_action :set_commande, only: [:show, :edit, :update, :destroy]
  # GET /commandes
  # GET /commandes.json
  def index
    @commandes = Commande.all(:order=>"updated_at desc")
    @produits=Produit.active
    @clients=Client.active
    @client_string='["'
    @clients.each do |cl|
      @client_string+=cl.nom+'","'
    end
     @client_string+='"]'
    @commande = Commande.new
  end

  # GET /commandes/1
  # GET /commandes/1.json
  def show
  end

  # GET /commandes/new
  def new
    @commande = Commande.new
  end

  # GET /commandes/1/edit
  def edit
  end

  # POST /commandes
  # POST /commandes.json
  def create
    @commande = Commande.new(commande_params)
    @client=Client.find_by_nom(params[:client])
    unless @client.nil?
      @commande.client_id=@client.id
    else
      old_code=Client.last.code[-7..-1] 
         code="CL"+old_code.next 
      @client=Client.create(nom: params[:client],phone: "655206994",code: code,address: "Douala-cameroun",ville: "Douala",pay_id: 30)
      @commande.client_id=@client.id
    end
    @list_produit=params[:list_produits]
    @montant=params[:montant]
    @paiement=params[:paiement]
   
    if @commande.save
      @list_produit=@list_produit[0..-2] 
      @list_produit=@list_produit.split(';')
      @list_produit.each do |lp|
        produit=lp.split(',')
        cmd_prd=CommandeProduit.new
        cmd_prd.commande_id=@commande.id
        cmd_prd.produit_id=produit[0].to_i
        cmd_prd.quantite=produit[1].to_i
        cmd_prd.remise=produit[2].to_i
        cmd_prd.save
        Produit.find(cmd_prd.produit_id).update_attribute(:quantite_stock,Produit.find(cmd_prd.produit_id).quantite_stock-cmd_prd.quantite)
      end
      
      @facture=Facture.new
      if Facture.count>0
        code=Facture.last.num.next
      else
        code=1
      end
      @facture.num=code
      @facture.commande_id=@commande.id
      @facture.client_id=@commande.client_id
      @facture.is_solde=@commande.en_cour
      @facture.montant=@montant
      @facture.versement=@paiement
      @facture.date_facture=Date.today
      @facture.save
      
    end
    @commande=Commande.new
     @commandes=Commande.all(:order=>"updated_at desc")
    flash[:notice]='Commande éffectué!!!'
    # redirect_to controller: "commandes"
  end
  
  def list
    @commandes=Commande.all(:order=>"updated_at desc")
  end

  def solde_commande
    @code=params[:code]
    @id=params[:id_cmd]
    @montant=params[:montant_solde]
   @commandes=Commande.all(:order=>"updated_at desc")
    @commande=Commande.find(@id)
    @facture=Facture.find_by_commande_id(@commande.id)
    @old_versement=@facture.versement
    @reste=@facture.montant - @old_versement
    if @montant.to_f <= @reste && @montant.to_f >=0
      @facture.update_attribute("versement",@old_versement+@montant.to_f)
      if @facture.versement==@facture.montant
        @msg="Commande soldé!!!"
        @commande.update_attribute("en_cour",false)
        #  @facture.update_attribute(:is_solde,true)
      else
        @msg="Reste #{(@facture.montant-@facture.versement).to_s} à payer pour cette facture!!!"
      end
   
    else
      flash[:notice]="le montant doit être <= au reste et supérieur à 0!!! "
    end
    
  end
  # PATCH/PUT /commandes/1
  # PATCH/PUT /commandes/1.json
  def update
    respond_to do |format|
      if @commande.update(commande_params)
        format.html { redirect_to @commande, notice: 'Commande was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @commande.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commandes/1
  # DELETE /commandes/1.json
  
  def recherche_commande
 @etat=false
 if params[:etat]=="0"
   @etat=false
 else
   @etat=true
 end
   if params[:date_debut]!="" || params[:date_fin]!="" || params[:nom]!="" || params[:etat]!=""
     
      @commandes=params[:etat]!=""? Commande.find_by_sql("SELECT commandes.* FROM commandes INNER JOIN clients on clients.id=commandes.client_id where clients.nom like '#{params[:nom]}%' and commandes.en_cour =#{@etat} and commandes.created_at>='#{params[:date_debut]}' and commandes.created_at<='#{params[:date_fin]}'"):
        Commande.find_by_sql("SELECT commandes.* FROM commandes INNER JOIN clients on clients.id=commandes.client_id where clients.nom like '#{params[:nom]}%' and commandes.created_at>='#{params[:date_debut]}' and commandes.created_at<='#{params[:date_fin]}'")
  else
      @commandes = Commande.all
    end
    
    render :partial=>"index" 
  end
  
  def commande_recu_pdf
    @facture=Facture.find(params[:facture_id])
    @commande=@facture.commande
    @commande_produits=CommandeProduit.find_all_by_commande_id(@commande.id)
    render :pdf =>"facture", page_size:  'A9' 
  end
  
  def destroy
    @commande.destroy
    respond_to do |format|
      format.html { redirect_to commandes_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_commande
    @commande = Commande.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def commande_params
    params.require(:commande).permit(:code, :en_cour, :client_id, :user_id, :is_deleted,:montant)
  end
end
