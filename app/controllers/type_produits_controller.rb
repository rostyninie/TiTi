class TypeProduitsController < ApplicationController
  
  before_filter :login_required
  filter_access_to :all
  before_action :set_type_produit, only: [:show, :edit, :update, :destroy]

  # GET /type_produits
  # GET /type_produits.json
  def index
    @type_produits = TypeProduit.all
  end

  # GET /type_produits/1
  # GET /type_produits/1.json
  def show
  end

  # GET /type_produits/new
  def new
    @type_produit = TypeProduit.new
  end

  # GET /type_produits/1/edit
  def edit
  end

  # POST /type_produits
  # POST /type_produits.json
  def create
   @type_produits=TypeProduit.all
    @type_produit = TypeProduit.create(type_produit_params)
    flash[:notice]="Type de produit créer avec succès!!!"
  end

  # PATCH/PUT /type_produits/1
  # PATCH/PUT /type_produits/1.json
  def update
     @type_produits=TypeProduit.all
   
    @type_produit.update_attributes(type_produit_params)
    flash[:notice]="Modification éffectué avec succès!!!"
  end
  
  def delete
   @type_produit = TypeProduit.find(params[:id])
   @type_produit.nom=@type_produit.nom.force_encoding("UTF-8")
end

  # DELETE /type_produits/1
  # DELETE /type_produits/1.json
  def destroy
    @type_produits=TypeProduit.all
   
    @type_produit.update_attribute(:is_active,false)
    flash[:notice]="Suppréssion éffectué avec succès!!!"
  end

  def recherche_type_produit
    @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
    
    if params[:nom]
      @type_produits=params[:etat]!=""? TypeProduit.find(:all,:conditions=>["nom LIKE ? and is_active= ?","#{params[:nom]}%",@test], :order=>"nom asc"):
      TypeProduit.find(:all,:conditions=>["nom LIKE ?","#{params[:nom]}%"], :order=>"nom asc") 
    else
      @type_produits=TypeProduit.all 
    end

    render :partial=>"index" 
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_produit
      @type_produit = TypeProduit.find(params[:id])
    @type_produit.nom=@type_produit.nom.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_produit_params
      params.require(:type_produit).permit(:code, :nom, :is_active)
    end
end
