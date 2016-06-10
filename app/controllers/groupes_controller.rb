class GroupesController < ApplicationController
  before_action :set_groupe, only: [:show, :edit, :update, :destroy]
   before_filter :login_required
   filter_access_to :all
  # GET /groupes
  # GET /groupes.json
  def index
    @groupes = Groupe.all
  end

  # GET /groupes/1
  # GET /groupes/1.json
  def show
  end

  # GET /groupes/new
  def new
    @groupe = Groupe.new
  end

  # GET /groupes/1/edit
  def edit
  end

  # POST /groupes
  # POST /groupes.json
  def create
    @groupes = Groupe.all
    @groupe = Groupe.create(groupe_params)
    flash[:notice]="Groupe crée avec succès!!!"
    
  end

  # PATCH/PUT /groupes/1
  # PATCH/PUT /groupes/1.json
  def update
    @groupes = Groupe.all
    @groupe.update_attributes(groupe_params)
    flash[:notice]="Groupe Modifié avec succès!!!"
  end
  
 def delete
    @groupe = Groupe.find(params[:id])
    @groupe.nom=@groupe.nom.force_encoding("UTF-8")
    @groupe.description=@groupe.description.force_encoding("UTF-8")
 end
  # DELETE /groupes/1
  # DELETE /groupes/1.json
  def destroy
    @groupes = Groupe.all
    if GroupeCategorie.find_all_by_groupe_id(@groupe.id).count==0
      @groupe.destroy
      flash[:notice]="Groupe Supprimé avec succès!!!"
    else
      flash[:notice]="Veillez d'abord retirer toute les catégories de droit affectés à ce groupe avant de le supprimer!!!"
    end
    
    
  end

  def view
    @group=Groupe.find(params[:id])
    @categories=GroupeCategorie.all(:conditions=>"groupe_id=#{@group.id}")
    @all_categories=Category.all(:conditions=>{is_active: true})
    if request.post?
     if params[:groupes][:categorie_ids].first
      @categorie_ids=params[:groupes][:categorie_ids]
     
      @categorie_ids.each do |c|
      if GroupeCategorie.find_by_category_id_and_groupe_id(c,@group.id).nil?
      @groupe_categorie=GroupeCategorie.new
      @groupe_categorie.groupe_id=@group.id
      @groupe_categorie.category_id=c
      @groupe_categorie.save
      end
      
     end 
     end
   
     flash[:notice]="Droits ajoutés avec succès!!!"
    redirect_to :controller=>"groupes",:action=>"view",:id=>@group.id
    end
   # render :pdf=>"view"
  end
  
  def create2
    @categories=Categorie.all(:conditions=>"is_active=true")
    @groupe_id=params[:id]
  if request.post?
    
    @categorie_ids=params[:groupes][:categorie_ids]
    @categorie_ids.each do |c|
      @groupe_categorie=GroupeCategorie.new
      @groupe_categorie.groupe_id=@groupe_id
      @groupe_categorie.categorie_id=c
      @groupe_categorie.save
     
    end
    flash[:notice]="les droits ont été affectés au groupe avec succès!!!"
    redirect_to :controller=>"groupe"
  end
  end
  
  def delete_categorie
   @group_categorie=GroupeCategorie.find(params[:id])
   unless @group_categorie.nil?
     @groupe=@group_categorie.groupe_id
     @group_categorie.destroy
     if @group_categorie.destroyed?
       flash[:notice]="Droits supprimer avec succès!!!"
    redirect_to :controller=>"groupes",:action=>"view",:id=>@groupe
     else
       flash[:notice]="Problème lors de la suppréssion!!!"
    redirect_to :controller=>"groupes",:action=>"view",:id=>@groupe
     end
   end
 end
 
  def recherche_groupe
    @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
   
      @groupes=params[:etat]!=""? Groupe.find(:all,:conditions=>["nom LIKE ? and is_active= ?","#{params[:nom]}%",@test], :order=>"nom asc"):
       Groupe.find(:all,:conditions=>["nom LIKE ? ","#{params[:nom]}%"], :order=>"nom asc")
   
      
  
    render :partial=>"index" 
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groupe
      @groupe = Groupe.find(params[:id])
      @groupe.nom=@groupe.nom.force_encoding("UTF-8")
      @groupe.description=@groupe.description.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def groupe_params
      params.require(:groupe).permit(:nom, :code, :description, :is_active)
    end
end
