class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:delete]
  protect_from_forgery except: :create
   layout :choose_layout
    before_filter :is_loggedin, :only => [:login]
    before_filter :message_user
    before_filter :login_required, :except=>[:login,:set_new_password,:verif_admin,:new_password]
  # GET /users
  # GET /users.json
   def choose_layout
    return 'login' if action_name == 'login'
    'application'
   
  end
  
  def index
    @users = User.active
    @groupes=Groupe.all(:conditions=>"is_active=true")
  end
  def user_by_groupe
    @users=User.find_all_by_groupe_id_and_is_active(params[:groupe_id],true,:order=>"nom ASC")

    render :partial=>"index" 

  end
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @groupes=Groupe.all(:conditions=>"is_active=true")
  end

  # GET /users/1/edit
  def edit
     @groupes=Groupe.all(:conditions=>"is_active=true")
  end

  # POST /users
  # POST /users.json
  def create
    #@user = User.new(user_params)
    @users=User.active
    @verifpass=params[:verif][:verifpasse]
    @passe=params[:user][:passe]
    #      if @passe.to_s==@verifpass
    @user=User.new
    @user.compte=params[:user][:compte]
    @date=params[:user]["date_naissance(3i)"]+"-"+params[:user]["date_naissance(2i)"]+"-"+params[:user]["date_naissance(1i)"]
    @user.date_naissance=@date.to_date
    @user.groupe_id=params[:user][:groupe_id]
    @user.nom=params[:user][:nom]
    @user.passe=Digest::SHA1.hexdigest(params[:user][:passe])
    @user.prenom=params[:user][:prenom]
    @user.tel=params[:user][:tel]
    @user.is_admin=params[:user][:is_admin]
  #  @user.photo=params[:user][:photo]
      
    if  @user.save
      flash[:notice]="#{@date} Utilisateur enregistré!!!"
     # redirect_to :controller=>"users"
    else
      if @user.errors.any?
        @result=""
        @user.errors.full_messages.each_with_index  do |message,i|  
          @result+="#{i} - #{message} ;" 
        end
        flash[:notice]= @result
      end
     # redirect_to :controller=>"users"
    end
    #      end
    #      else
    #       flash[:notice]="les mots de passe ne sont pas identiques"+@verifpass+" "+@passe
    #        redirect_to :controller=>"user",:action=>"create"  
    #      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
     @user=User.find(params[:id])
     passe=""
     if params[:user][:a_passe]!=""
     passe=Digest::SHA1.hexdigest(params[:user][:a_passe])
     end
     if params[:user][:a_passe]!="" && passe!=@user.passe
       @user.errors.add(:passe, " : l'encien mot de passe n'est pas valide") 
     else
        #@user.update_attributes(user_params)
        if params[:user][:passe]!="" && params[:user][:a_passe]!=""
           @user.update_attribute(:passe,Digest::SHA1.hexdigest(params[:user][:passe]))
        end
        @user.update_attribute(:compte,params[:user][:compte])
        @user.update_attribute(:nom,params[:user][:nom].force_encoding("UTF-8"))
        @user.update_attribute(:prenom,params[:user][:prenom].force_encoding("UTF-8"))
        @user.update_attribute(:tel,params[:user][:tel])
        @user.update_attribute(:date_naissance,params[:user][:date_naissance])
        @user.update_attribute(:groupe_id,params[:user][:groupe_id])
        @user.is_admin=params[:user][:is_admin]
        
      # :compte, :nom, :prenom, :tel, :date_naissance, :groupe_id
    flash[:notice]="Modification éffectué avec succès!!!"

     end
     @users=User.active
  end

  def delete
    
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @users=User.active
    @user.update_attribute(:is_active,false)
    flash[:notice]="Suppréssion éffectué avec succès!!!"
  end
  
  def login
  if cookies[:use_id]
    @user=User.find(cookies[:use_id].to_i)
     session[:user_id]=@user.id
        flash[:notice]="Bienvenue M "+@user.prenom.force_encoding("UTF-8")
        redirect_to session[:back_url] || {:controller => 'users', :action => 'dashboard', :id => 0}
  end
  if request.post?
    @email=params[:login][:email]
    @passe=params[:login][:passe]
    if @email=="" || @passe==""
     flash[:notice]="veuillez remplire tous les champs svp!!!"
     redirect_to :controller => 'users', :action => 'login'   
      
    else
    @user=User.find_by_compte(@email)
    if @user.present?
      if @user.passe==Digest::SHA1.hexdigest(@passe)
        if !params[:login][:remenber_me].nil?
          cookies[:use_id]={:value=>@user.id,:expires=> 1.month.from_now}
        end
        session[:user_id]=@user.id
        if @user.first_login
           flash[:notice]="Bienvenue M "+@user.full_name.force_encoding("UTF-8")+" Veillez changer votre mot de passe svp!!!"
        redirect_to  :controller => 'users', :action => 'first_login_change_password', :id => @user.id
        else
           flash[:notice]="Bienvenue M "+@user.full_name.force_encoding("UTF-8")
        redirect_to session[:back_url] || {:controller => 'users', :action => 'dashboard', :id => 0}
        end
       
      else
        # flash[:notice]="connexion échoué. Mot de passe incorrect!!!"+@passe.hash.to_s
          flash[:notice]="connexion échoué. Mot de passe incorrect!!!"
        redirect_to :controller => 'users', :action => 'login'
      end
    else
     flash[:notice]="connexion échoué. cet email n'est pas valide!!!"
     redirect_to :controller => 'users', :action => 'login'  
    end
     
  end
  end
 
  
end

def deconnexion
  Rails.cache.delete("user_main_menu#{session[:user_id]}")
    Rails.cache.delete("user_autocomplete_menu#{session[:user_id]}")
    session[:user_id] = nil
    if cookies[:use_id]
 cookies.delete :use_id
    end
    flash[:notice] = "#{"Déconnecté!!!"}"
    redirect_to :controller => 'users', :action => 'login' and return
end

def first_login_change_password
  @user=User.find(params[:id])
  if request.post?
    passe=params[:change_passe][:passe]
    passe=Digest::SHA1.hexdigest(passe)
    @user.update_attribute(:passe,passe)
    @user.update_attribute(:first_login,false)
     flash[:notice]="Bienvenue M "+@user.full_name
     redirect_to :controller => 'users', :action => 'dashboard', :id => 0
  end
end
def set_new_password
  
end
def verif_admin
  compte=params[:set_password][:email]
  passe=params[:set_password][:passe]
  passe=Digest::SHA1.hexdigest(passe)
  user=User.find_by_compte_and_passe(compte,passe)
  unless user.nil?
    unless user.is_admin
       flash[:notice]="Désolé cet utilisateur n'est pas administrateur dans le système!!!"
    else
      flash[:notice]=nil
    end
  else
    flash[:notice]="Désolé cet utilisateur n'existe pas dans le système!!!"
  end
end

def new_password
  compte=params[:new_password][:compte]
  passe=params[:new_password][:passe]
  
  @user=User.find_by_compte(compte)
  unless @user.nil?
   passe=Digest::SHA1.hexdigest(passe)
   @user.update_attribute(:passe, passe)
   @user.update_attribute(:first_login, true)
   flash[:notice]=nil
  else
    flash[:notice]="Désolé ce compte ne correspond à aucun utilisateur dans le système!!!"
  end
end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    @user.nom=@user.nom.force_encoding("UTF-8")
    @user.prenom=@user.prenom.force_encoding("UTF-8")
     
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:compte, :nom, :prenom, :tel, :date_naissance, :groupe_id, :passe, :is_active,:is_admin)
  end
end
