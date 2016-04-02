class AchatsController < ApplicationController
  before_filter :login_required
  before_filter :message_user
  before_action :set_achat, only: [:show, :edit, :update, :destroy]

  # GET /achats
  # GET /achats.json
  def index
    @achats = Achat.all
    @achat = Achat.new
  end

  # GET /achats/1
  # GET /achats/1.json
  def show
  end

  # GET /achats/new
  def new
    @achat = Achat.new
  end

  # GET /achats/1/edit
  def edit
  end

  # POST /achats
  # POST /achats.json
  def create
    @achats=Achat.all
    @achat = Achat.create(achat_params)
    @achat.update_attribute(:date_achat,params[:achat][:date_achat])
    @achat.update_attribute(:prix_vente,params[:prix_vente])
    @produit=Produit.find(@achat.produit_id)
    quantite_stock=@produit.quantite_stock>0?(@achat.quantite+@produit.quantite_stock):@achat.quantite
    @produit.update_attribute(:quantite_stock,quantite_stock)
    @produit.update_attribute(:prix_vente,params[:prix_vente])
    @produit.update_attribute(:prix_gros,(@produit.quantite_gros*@produit.prix_vente))
    flash[:notice]="Achat éffectué avec succès!!!"
    @achat=Achat.new
#    respond_to do |format|
#      if @achat.save
#        format.html { redirect_to @achat, notice: 'Achat
#         was successfully created.' }
#        format.json { render action: 'show', status: :created, location: @achat }
#      else
#        format.html { render action: 'new' }
#        format.json { render json: @achat.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # PATCH/PUT /achats/1
  # PATCH/PUT /achats/1.json
  def update
    
     @achats=Achat.all
     ancien_quantite=@achat.quantite
     ancien_date_achat=@achat.date_achat
     ancien_marge=@achat.marge_brut
     ancien_code=@achat.code
     ancien_pu=@achat.prix_achat_unitaire
     ancien_user_id=@achat.user_id
     ancien_produit_id=@achat.produit_id
      ancien_prix_ht=@achat.prix_ht
      ancien_prix_vente=@achat.prix_vente
        @produit=Produit.find(@achat.produit_id)
        if ancien_quantite<=@produit.quantite_stock
   @produit.update_attribute(:quantite_stock,(@produit.quantite_stock-ancien_quantite))
      
      @achat.update(achat_params)
    @achat.update_attribute(:date_achat,params[:achat][:date_achat])
    @achat.update_attribute(:prix_vente,params[:prix_vente])
    #@produit=Produit.find(@achat.produit_id)
    quantite_stock=@produit.quantite_stock>0?(@achat.quantite+@produit.quantite_stock):@achat.quantite
    @produit.update_attribute(:quantite_stock,quantite_stock)
    if params[:prix_vente]
    @produit.update_attribute(:prix_vente,params[:prix_vente])
    @produit.update_attribute(:prix_gros,(@produit.quantite_gros*@produit.prix_vente))
    end
    flash[:notice]="Achat modifier avec succès!!!"
    acha_hsto=AchatHistory.new
    acha_hsto.code=ancien_code
    acha_hsto.created_at=ancien_date_achat
    acha_hsto.marge_brut=ancien_marge
    acha_hsto.prix_achat_unitaire=ancien_pu
    acha_hsto.prix_ht=ancien_prix_ht
    acha_hsto.prix_vente=ancien_prix_vente
    acha_hsto.produit_id=ancien_produit_id
    acha_hsto.quantite=ancien_quantite
    acha_hsto.user_id=ancien_user_id
    acha_hsto.save
     acha_hsto.update_attribute(:date_achat,ancien_date_achat)
    @achat=Achat.new
        else
          @achat.errors.add(:quantite, " : impossible de modifier cet achat car des ventes on déjà été éffectués sur l'ancienne quantité!!!")
        end
    
    
  end

  
  
  def achat_history
    @achat_histories=AchatHistory.find_all_by_produit_id_and_code(params[:id],params[:code])
  end
  
  # DELETE /achats/1
  # DELETE /achats/1.json
  def destroy
    @achat.destroy
    respond_to do |format|
      format.html { redirect_to achats_url }
      format.json { head :no_content }
    end
  end

  def seach_product
    if params[:type_id]!=""
    @produits=Produit.find_all_by_type_produit_id(params[:type_id])
    else
      @produits=Produit.active
    end
    render :partial => "seach_product"
  end
  
  def recherche_achat
   
     nom_produit=""
     nom_fournisseur=""
    unless params[:produit_id]==""
      nom_produit=Produit.find_by_id(params[:produit_id]).nom 
    end
     unless params[:fournisseur_id]==""
       nom_fournisseur=Fournisseur.find_by_id(params[:fournisseur_id]).nom
     end
     
     
    
   if params[:date_debut]!="" || params[:date_fin]!="" || params[:produit_id]!="" || params[:fournisseur_id]!=""
      @achats=Achat.find_by_sql("SELECT achats.* FROM achats INNER JOIN produits on produits.id=achats.produit_id INNER JOIN fournisseurs on fournisseurs.id=achats.fournisseur_id where produits.nom like '#{nom_produit}%' and fournisseurs.nom like '#{nom_fournisseur}%' and achats.date_achat>='#{params[:date_debut]}' and achats.date_achat<='#{params[:date_fin]}'")
  else
      @achats = Achat.all
    end
    
    render :partial=>"index" 
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_achat
      @achat = Achat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def achat_params
      params.require(:achat).permit(:code, :prix_achat_unitaire, :marge_brut, :prix_ht, :quantite, :date_achat, :user_id, :produit_id, :fournisseur_id,:prix_vente, :is_deleted)
    end
end
