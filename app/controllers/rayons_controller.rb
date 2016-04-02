class RayonsController < ApplicationController
  before_filter :login_required
  before_action :set_rayon, only: [:show, :edit, :update, :destroy,:delete]

  # GET /rayons
  # GET /rayons.json
  def index
    @rayons = Rayon.all
  end

  # GET /rayons/1
  # GET /rayons/1.json
  def show
  end

  # GET /rayons/new
  def new
    @rayon = Rayon.new
  end

  # GET /rayons/1/edit
  def edit
  end

  # POST /rayons
  # POST /rayons.json
  def create
    @rayon = Rayon.new(rayon_params)
     @rayons=Rayon.all
    @rayon = Rayon.create(rayon_params)
    flash[:notice]="Rayon créer avec succès!!!"
  end

  # PATCH/PUT /rayons/1
  # PATCH/PUT /rayons/1.json
  def update
    @rayons=Rayon.all
   
    @rayon.update_attributes(rayon_params)
    flash[:notice]="Modification éffectué avec succès!!!"
  end

  def delete
  
   @rayon.nom=@rayon.nom.force_encoding("UTF-8")
end
  
  # DELETE /rayons/1
  # DELETE /rayons/1.json
  def destroy
     @rayons=Rayon.all
   
    @rayon.update_attribute(:is_active,false)
    flash[:notice]="Suppréssion éffectué avec succès!!!"
  end
  
  def recherche_rayon
    @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
    
    if params[:nom]
      @rayons=params[:etat]!=""? Rayon.find(:all,:conditions=>["nom LIKE ? and is_active= ?","#{params[:nom]}%",@test], :order=>"nom asc"):
      Rayon.find(:all,:conditions=>["nom LIKE ?","#{params[:nom]}%"], :order=>"nom asc") 
    else
      @rayons=Rayon.all 
    end

    render :partial=>"index" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rayon
      @rayon = Rayon.find(params[:id])
      @rayon.nom=@rayon.nom.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rayon_params
      params.require(:rayon).permit(:code, :nom, :is_active)
    end
end
