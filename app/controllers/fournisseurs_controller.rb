class FournisseursController < ApplicationController
   before_filter :login_required
   before_filter :message_user
   filter_access_to :all
  before_action :set_fournisseur, only: [:show, :edit, :update, :destroy,:coordonne_bancaires]

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
  
  
  def coordonne_bancaires
     
   @coordonne_fours=CoordonneFournisseur.all(:conditions=>"fournisseur_id=#{@fournisseur.id}")
    @coordonnes=CoordonneBancaire.find_by_sql("SELECT * FROM coordonne_bancaires  where is_active=true and id not in (select coordonne_bancaire_id FROM coordonne_fournisseurs where fournisseur_id=#{@fournisseur.id})")
    if request.post?
     if params[:fournisseurs][:coordonne_ids].first
      @coordonne_ids=params[:fournisseurs][:coordonne_ids]
     
      @coordonne_ids.each do |c|
      if CoordonneFournisseur.find_by_coordonne_bancaire_id_and_fournisseur_id(c,@fournisseur.id).nil?
      @coord_f=CoordonneFournisseur.new
      @coord_f.coordonne_bancaire_id=c
      @coord_f.fournisseur_id=@fournisseur.id
      @coord_f.save
      end
      
     end 
     end
   
     flash[:notice]="Coordonné(s) ajouté(s) avec succès!!!"
    redirect_to :controller=>"fournisseurs",:action=>"coordonne_bancaires",:id=>@fournisseur.id
    end
  end

  
  def delete_coordonne
    @coordonne_four =CoordonneFournisseur.find(params[:id])
   unless @coordonne_four.nil?
     @fournisseur_id=@coordonne_four.fournisseur_id
     @coordonne_four.destroy
     if @coordonne_four.destroyed?
        @coordonnes=CoordonneBancaire.find_by_sql("SELECT * FROM coordonne_bancaires  where is_active=true and id not in (select coordonne_bancaire_id FROM coordonne_fournisseurs where fournisseur_id=#{@fournisseur_id})")

       flash[:notice]="Droits supprimer avec succès!!!"
   redirect_to :controller=>"fournisseurs",:action=>"coordonne_bancaires",:id=>@fournisseur_id
     else
        @coordonnes=CoordonneBancaire.find_by_sql("SELECT * FROM coordonne_bancaires  where is_active=true and id not in (select coordonne_bancaire_id FROM coordonne_fournisseurs where fournisseur_id=#{@fournisseur_id})")

       flash[:notice]="Problème lors de la suppréssion!!!"
    redirect_to :controller=>"fournisseurs",:action=>"coordonne_bancaires",:id=>@fournisseur_id
     end
   end
 end
 
  def update_coordonne
    @coordonne_four =CoordonneFournisseur.find(params[:id])
   
  end
  
  def save_value_cood
     @coordonne_four =CoordonneFournisseur.find(params[:id])
      @valeur=params[:fournisseurs][:valeur]
    @coordonne_four.update_attribute(:valeur,@valeur)
    flash[:notice]="valeur modifiée!!!"
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
