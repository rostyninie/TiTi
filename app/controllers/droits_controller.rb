class DroitsController < ApplicationController
  
    before_filter :login_required
    filter_access_to :all
    before_action :set_droit, only: [:show, :edit, :update, :destroy]
  # GET /droits
  # GET /droits.json
  def index
    @droits = Droit.all
  end

  # GET /droits/1
  # GET /droits/1.json
  def show
  end

 
  # GET /droits/new
  def new
    @droit = Droit.new
#    respond_to do |format|
#    format.js {}
#    end
  end

  # GET /droits/1/edit
  def edit
  end

  # POST /droits
  # POST /droits.json
  def create
    @droits=Droit.all
    @droit = Droit.create(droit_params)
    flash[:notice]="Droit créer avec succès!!!"
  end

  # PATCH/PUT /droits/1
  # PATCH/PUT /droits/1.json
  def update
    @droits=Droit.all
    @droit=Droit.find(params[:id])
    @droit.update_attributes(droit_params)
    flash[:notice]="Modification éffectué avec succès!!!"
  end

  # DELETE /droits/1
  # DELETE /droits/1.json
  def destroy
    
    @droits=Droit.all
    @droit=Droit.find(params[:id])
    @droit.destroy
    flash[:notice]="Droit supprimer avec succès!!!"
   
  end
def delete
  @droit=Droit.find(params[:id])
  @droit.name=@droit.name.force_encoding("UTF-8")
end

 def recherche_droit
    @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
   if params[:category]==""
      @droits=params[:etat]!=""? Droit.find(:all,:conditions=>["name LIKE ? and is_active= ?","#{params[:nom]}%",@test], :order=>"name asc"):
        Droit.find(:all,:conditions=>["name LIKE ? ","#{params[:nom]}%"], :order=>"name asc")
   elsif params[:category]!=""
      @droits=params[:etat]!=""? Droit.find(:all,:conditions=>["name LIKE ? and is_active= ? and category_id=?","#{params[:nom]}%",@test,params[:category]], :order=>"name asc"):
        Droit.find(:all,:conditions=>["name LIKE ? and category_id=?","#{params[:nom]}%",params[:category]], :order=>"name asc")
   else
    @droits=Droit.all 
   end
     
   
      
  
    render :partial=>"index" 
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_droit
      @droit = Droit.find(params[:id])
      @droit.name=@droit.name.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def droit_params
      params.require(:droit).permit(:name, :code, :description,:category_id,:is_active)
    end
end
