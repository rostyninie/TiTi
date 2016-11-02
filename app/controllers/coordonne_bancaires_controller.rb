class CoordonneBancairesController < ApplicationController
  
  before_filter :login_required
   filter_access_to :all
  
  before_action :set_coordonne_bancaire, only: [:show, :edit, :update, :destroy, :delete]

  # GET /coordonne_bancaires
  # GET /coordonne_bancaires.json
  def index
    @coordonne_bancaires = CoordonneBancaire.all
  end

  # GET /coordonne_bancaires/1
  # GET /coordonne_bancaires/1.json
  def show
  end

  # GET /coordonne_bancaires/new
  def new
    @coordonne_bancaire = CoordonneBancaire.new
  end

  # GET /coordonne_bancaires/1/edit
  def edit
  end

  # POST /coordonne_bancaires
  # POST /coordonne_bancaires.json
  def create
   
   @coordonne_bancaires = CoordonneBancaire.all

   @coordonne_bancaire= CoordonneBancaire.create(coordonne_bancaire_params)
    flash[:notice]="Coordonné créer avec succès!!!"
  end

  # PATCH/PUT /coordonne_bancaires/1
  # PATCH/PUT /coordonne_bancaires/1.json
  def update
   @coordonne_bancaires = CoordonneBancaire.all
     #@category =Categorie.find(params[:id])
    @coordonne_bancaire.update(coordonne_bancaire_params)
    flash[:notice]="Coordonné Modifié avec succès!!!"
  end
  
  def delete
    
  end
  
  def recherche_coordonne
     @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
   
      @coordonne_bancaires = params[:etat]!=""? CoordonneBancaire.find(:all,:conditions=>["nom LIKE ? and is_active= ?","#{params[:nom]}%",@test], :order=>"nom asc"):
       CoordonneBancaire.find(:all,:conditions=>["nom LIKE ? ","#{params[:nom]}%"], :order=>"nom asc")
   
      
  
    render :partial=>"index" 
  end

  # DELETE /coordonne_bancaires/1
  # DELETE /coordonne_bancaires/1.json
  def destroy
    @coordonne_bancaires = CoordonneBancaire.all
    if @coordonne_bancaire.coordonne_clients.count==0 && @coordonne_bancaire.coordonne_fournisseurs.count==0
      @coordonne_bancaire.destroy
    
    flash[:notice]="Supprimé avec succès!!!"
    else
      flash[:notice]="impossible de supprimer ce coordonné car il est utilisé!!!"
    end
    
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coordonne_bancaire
      @coordonne_bancaire = CoordonneBancaire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coordonne_bancaire_params
      params.require(:coordonne_bancaire).permit(:code, :nom,:description, :is_active)
    end
end
