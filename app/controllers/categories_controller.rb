class CategoriesController < ApplicationController
  
   before_filter :login_required
   filter_access_to :all
   before_action :set_category, only: [:show, :edit, :update, :destroy]
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end
 def delete
   @category = Category.find(params[:id])
 end
  # POST /categories
  # POST /categories.json
  def create
    @categories = Category.all

   @category = Category.create(category_params)
    flash[:notice]="Catégorie créer avec succès!!!"
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
   @categories = Category.all
     #@category =Categorie.find(params[:id])
    @category.update(category_params)
    flash[:notice]="Catégorie Modifié avec succès!!!"
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @categories=Category.all
    @category.destroy
    flash[:notice]="Supprimé avec succès!!!"
   
  end
  
   def recherche_category
    @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
   
      @categories=params[:etat]!=""? Category.find(:all,:conditions=>["nom LIKE ? and is_active= ?","#{params[:nom]}%",@test], :order=>"nom asc"):
       Category.find(:all,:conditions=>["nom LIKE ? ","#{params[:nom]}%"], :order=>"nom asc")
   
      
  
    render :partial=>"index" 
  end

   def view
    @categorie=Category.find(params[:id])
   # @categorie_droit=GroupeCategorie.all(:conditions=>"groupe_id=#{@group.id}")
   
    
  end
  
   
   def delete_droit
   @droit=Droit.find(params[:id])
   unless @droit.nil?
     @id=@droit.category_id
     if @droit.update_attribute("is_active", false)
    flash[:notice]="Droit supprimer avec succès!!!"
    redirect_to :controller=>"categories",:action=>"view",:id=>@id
     else
    flash[:notice]="Problème lors de la suppréssion!!!"
    redirect_to :controller=>"categories",:action=>"view",:id=>@id
     end
   end
 end
   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      @category.nom=@category.nom.force_encoding("UTF-8")
      @category.description=@category.description.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:code, :nom, :description, :is_active)
    end
end
