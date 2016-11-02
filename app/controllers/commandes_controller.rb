class CommandesController < ApplicationController
  before_filter :message_user
  before_filter :login_required
  filter_access_to :all
  before_action :set_commande, only: [:show, :edit, :update, :destroy]
  # GET /commandes
  # GET /commandes.json
  def index
    @commandes = Commande.all(:order=>"updated_at desc")
    if Option.get_config_value('mode')=='1' || Option.get_config_value('mode')=='2'
     if Option.get_config_value('mode')=='1'
      @produits=Produit.active.where(mode: "simple")
     else
       @produits=Produit.active.where(mode: "fifo") + Produit.active.where(mode: "lifo")
     end
    else
      @uniques=[]
      #@uniques=UniqueProduit.where(etat: false,groupe_id: nil).all
      if Option.get_config_value('mode')=='4'
        @achats=Achat.where(is_active: true)
        @achats.each do |a|
          a.unique_produits.each do |u|
           if u.etat==false && u.groupe_id.nil?
            @uniques.push(u) 
           end
          end
        end
      elsif Option.get_config_value('mode')=='5'
        @achats=Achat.where(is_active: true)
         @achats.each do |a|
          a.unique_produits.each do |u|
           if u.etat==false && u.groupe_id.nil?
            @uniques.push(u) 
           end
          end
        end
      end
      
    end
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
      if Option.get_config_value('mode')=='1'
        @list_produit.each do |lp|
          produit=lp.split(',')
          cmd_prd=CommandeProduit.new
          cmd_prd.commande_id=@commande.id
          cmd_prd.produit_id=produit[0].to_i
          cmd_prd.quantite=produit[1].to_i
          cmd_prd.remise=produit[2].to_f
          cmd_prd.pu=produit[3].to_f
          cmd_prd.save
          @use_achats=Achat.where(is_active: true, produit_id: cmd_prd.produit_id)
          @qt = cmd_prd.quantite
          unless @use_achats.nil?
           @use_achats.each do |h|
             if h.sortie >= @qt
               h.sortie=h.sortie - @qt
               @qt=0;
             else
               
               @qt= @qt - h.sortie
               h.sortie=0
             end
             h.save 
            end
          end
          Produit.find(cmd_prd.produit_id).update_attribute(:quantite_stock,Produit.find(cmd_prd.produit_id).quantite_stock-cmd_prd.quantite)
        end
      
      elsif Option.get_config_value('mode')=='2'
          
        @list_produit.each do |lp|
          produit=lp.split(',')
          cmd_prd=CommandeProduit.new
          cmd_prd.commande_id=@commande.id
          cmd_prd.produit_id=produit[0].to_i
          cmd_prd.quantite=produit[1].to_i
          cmd_prd.remise=produit[2].to_f
          cmd_prd.pu=produit[3].to_f
          achat =Achat.find_by_is_active_and_produit_id(true, cmd_prd.produit_id)
          unless achat.nil?
            cmd_prd.achat_id=achat.id
          end
          cmd_prd.save
          Produit.find(cmd_prd.produit_id).update_attribute(:quantite_stock,Produit.find(cmd_prd.produit_id).quantite_stock-cmd_prd.quantite)
          achat.update_attribute(:sortie, (achat.sortie - cmd_prd.quantite)) unless achat.nil?
        end
      elsif Option.get_config_value('mode')=='4' || Option.get_config_value('mode')=='5' 
        @list_produit.each do |lp|
          produit=lp.split(',')
          cmd_prd=CommandeProduit.new
          cmd_prd.commande_id=@commande.id
          @unique=UniqueProduit.find_by_id(produit[0].to_i)
          cmd_prd.produit_id=@unique.produit_id
          quantite= UniqueProduit.find_all_by_groupe_id(@unique.id).count==0 ? produit[1].to_i : UniqueProduit.find_all_by_groupe_id(@unique.id).count
          cmd_prd.quantite= quantite
          cmd_prd.remise=produit[2].to_f
          cmd_prd.pu=produit[3].to_f
          cmd_prd.unique_produit_id=@unique.id
          cmd_prd.achat_id=@unique.achat_id
         
          cmd_prd.save
          list_s_pr=UniqueProduit.find_all_by_groupe_id(@unique.id)
    if list_s_pr.count>0
      list_s_pr.each do |pr|
        pr.update_attribute(:etat, true)
      end
    end
          Produit.find(cmd_prd.produit_id).update_attribute(:quantite_stock,Produit.find(cmd_prd.produit_id).quantite_stock-quantite)
          @unique.achat.update_attribute(:sortie, (@unique.achat.sortie - quantite)) unless @unique.achat.nil?
           @unique.update_attribute(:etat, true)
        end
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
      
   titre= "#{"Facture N°"} #{@facture.num}  #{" du "} #{@facture.date_facture}"
   montant=@facture.versement >= @facture.montant ? @facture.montant : @facture.versement 
   @transaction=Transaction.new(titre: titre,description: titre,montant: montant, commande_id: @commande.id,is_add: true, date_transaction: @facture.date_facture)
   @transaction.save
    end
       if Option.get_config_value('mode')=='1' || Option.get_config_value('mode')=='2'
      @produits=Produit.active
    else
      @uniques=[]
      #@uniques=UniqueProduit.where(etat: false,groupe_id: nil).all
      if Option.get_config_value('mode')=='4'
        @achats=Achat.where(is_active: true)
        @achats.each do |a|
          a.unique_produits.each do |u|
           if u.etat==false && u.groupe_id.nil?
            @uniques.push(u) 
           end
          end
        end
      elsif Option.get_config_value('mode')=='5'
        @achats=Achat.where(is_active: true)
         @achats.each do |a|
          a.unique_produits.each do |u|
           if u.etat==false && u.groupe_id.nil?
            @uniques.push(u) 
           end
          end
        end
      end
      
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
      Transaction.find_by_commande_id(@commande.id).update_attribute(:montant,Transaction.find_by_commande_id(@commande.id).montant + @montant.to_f)
      if @facture.versement==@facture.montant
        @msg="Commande soldé!!!"
        @commande.update_attribute("en_cour",false)
          @facture.update_attribute(:is_solde,false)
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

  def list_produit
    @commande=Commande.find_by_id(params[:id])
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
