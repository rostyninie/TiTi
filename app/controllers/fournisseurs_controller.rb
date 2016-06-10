class FournisseursController < ApplicationController
   before_filter :login_required
   before_filter :message_user
   filter_access_to :all
  before_action :set_fournisseur, only: [:show, :edit, :update, :destroy]

  # GET /fournisseurs
  # GET /fournisseurs.json
  def index
    @fournisseurs = Fournisseur.all
  end

  # GET /fournisseurs/1
  # GET /fournisseurs/1.json
  def show
  end

  # GET /fournisseurs/new
  def new
    @fournisseur = Fournisseur.new
  end

  # GET /fournisseurs/1/edit
  def edit
  end
  def delete
    @fournisseur = Fournisseur.find(params[:id])
    @fournisseur.nom=@fournisseur.nom.force_encoding("UTF-8")
      @fournisseur.ville=@fournisseur.ville.force_encoding("UTF-8")
      @fournisseur.address=@fournisseur.address.force_encoding("UTF-8")
  end

  # POST /fournisseurs
  # POST /fournisseurs.json
  def create
    @fournisseur = Fournisseur.create(fournisseur_params)
    @fournisseurs = Fournisseur.all
    flash[:notice]="Fournisseur créé avec succès!!!"
  
  end

  # PATCH/PUT /fournisseurs/1
  # PATCH/PUT /fournisseurs/1.json
  def update
    
       @fournisseur.update_attributes(fournisseur_params)
       @fournisseurs = Fournisseur.all
       flash[:notice]="Fournisseur Modifier avec succès!!!"
        
  end

  # DELETE /fournisseurs/1
  # DELETE /fournisseurs/1.json
  def destroy
    @fournisseur = Fournisseur.find(params[:id])
    @fournisseur.update_attribute(:is_active,false)
    @fournisseurs = Fournisseur.all
   flash[:notice]="Fournisseur supprimé avec succès!!!"
  end

  def recherche_fournisseur
     @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
   if params[:pays]==""
      @fournisseurs=params[:etat]!=""? Fournisseur.find(:all,:conditions=>["nom LIKE ? and is_active= ? and ville LIKE ?","#{params[:nom]}%",@test,"#{params[:ville]}%"], :order=>"nom asc"):
        Fournisseur.find(:all,:conditions=>["nom LIKE ?  and ville LIKE ?","#{params[:nom]}%","#{params[:ville]}%"], :order=>"nom asc")
   elsif params[:pays]!=""
     #nom_pay=Pay.find(params[:pays]).nom
      @fournisseurs=params[:etat]!=""? Fournisseur.find(:all,:conditions=>["nom LIKE ? and is_active= ? and pay_id=? and ville LIKE ?","#{params[:nom]}%",@test,params[:pays],"#{params[:ville]}%"], :order=>"nom asc"):
        Fournisseur.find(:all,:conditions=>["nom LIKE ? and pay_id=? and ville LIKE ?","#{params[:nom]}%",params[:pays],"#{params[:ville]}%"], :order=>"nom asc")
   else
      @fournisseurs = Fournisseur.all
    end
    
    render :partial=>"index" 
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fournisseur
      @fournisseur = Fournisseur.find(params[:id])
      @fournisseur.nom=@fournisseur.nom.force_encoding("UTF-8")
      @fournisseur.ville=@fournisseur.ville.force_encoding("UTF-8")
      @fournisseur.address=@fournisseur.address.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fournisseur_params
      params.require(:fournisseur).permit(:code, :nom, :phone, :address, :ville, :pay_id,:is_active)
    end
end
