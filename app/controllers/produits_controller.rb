class ProduitsController < ApplicationController
  before_filter :login_required
  filter_access_to :all
  before_action :set_produit, only: [:show, :edit, :update, :destroy,:delete]

  # GET /produits
  # GET /produits.json
  def index
    @produits = Produit.all
  end

  # GET /produits/1
  # GET /produits/1.json
  def show
  end

  # GET /produits/new
  def new
    @produit = Produit.new
  end

  # GET /produits/1/edit
  def edit
  end
  
  def delete
    
  end

  # POST /produits
  # POST /produits.json
  def create
     @produit = Produit.create(produit_params)
    @produits = Produit.all
    flash[:notice]="Produit créé avec succès!!!"
  end

  # PATCH/PUT /produits/1
  # PATCH/PUT /produits/1.json
  def update
    @produit.update_attributes(produit_params)
    @produits = Produit.all
    flash[:notice]="Produit Modifié avec succès!!!"
  end

  # DELETE /produits/1
  # DELETE /produits/1.json
  def destroy
   @produit= Produit.find(params[:id])
    @produit.update_attribute(:is_active,false)
    @produits = Produit.all
   flash[:notice]="Produit supprimé avec succès!!!"
  end
  
   def recherche_produit
     nom=""
     etat=""
     nom_rayon=""
     nom_tp=""
    unless params[:rayon]==""
      nom_rayon=Rayon.find_by_id(params[:rayon]).nom 
    end
     unless params[:type_produit]==""
       nom_tp=TypeProduit.find_by_id(params[:type_produit]).nom
     end
     
     
     nom=params[:nom] unless params[:nom]==""
     @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
   if params[:etat]!="" || params[:nom]!="" || params[:rayon]!="" || params[:type_produit]!=""
      @produits=params[:etat]!=""? Produit.find_by_sql("SELECT produits.* FROM produits INNER JOIN rayons on produits.rayon_id=rayons.id INNER JOIN type_produits on produits.type_produit_id=type_produits.id where rayons.nom like '#{nom_rayon}%' and type_produits.nom like '#{nom_tp}%' and produits.nom like '#{nom}%' and produits.is_active=#{@test}"):
        Produit.find_by_sql("SELECT produits.* FROM produits INNER JOIN rayons on produits.rayon_id=rayons.id INNER JOIN type_produits on produits.type_produit_id=type_produits.id where rayons.nom like '#{nom_rayon}%' and type_produits.nom like '#{nom_tp}%' and produits.nom like '#{nom}%'")
  else
      @produits = Produit.all
    end
    
    render :partial=>"index" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produit
      @produit = Produit.find(params[:id])
      @produit.nom=@produit.nom.force_encoding("UTF-8")
      @produit.unite=@produit.unite.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produit_params
      params.require(:produit).permit(:code, :nom, :prix_vente, :prix_gros, :quantite_gros, :quantite_stock, :unite, :type_produit_id, :rayon_id, :is_active,:seuil_warning,:seuil_danger,:mode,:cump)
    end
end
