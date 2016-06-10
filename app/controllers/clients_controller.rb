class ClientsController < ApplicationController
   before_filter :login_required
   before_filter :message_user
   filter_access_to :all
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end
  
  def delete
     @client = Client.find(params[:id])
     @client.nom=@client.nom.force_encoding("UTF-8")
     @client.ville=@client.ville.force_encoding("UTF-8")
     @client.address=@client.address.force_encoding("UTF-8")
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.create(client_params)
    @clients = Client.all
    flash[:notice]="client créé avec succès!!!"
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
     @client.update_attributes(client_params)
       @clients = Client.all
       flash[:notice]="Client Modifier avec succès!!!"
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client= Client.find(params[:id])
    @client.update_attribute(:is_active,false)
    @clients = Client.all
   flash[:notice]="Client supprimé avec succès!!!"
  end

   def recherche_client
     @test=false
    if params[:etat]=="active"
      @test=true
    else
      @test=false
    end
   if params[:pays]==""
      @clients=params[:etat]!=""? Client.find(:all,:conditions=>["nom LIKE ? and is_active= ? and ville LIKE ?","#{params[:nom]}%",@test,"#{params[:ville]}%"], :order=>"nom asc"):
        Client.find(:all,:conditions=>["nom LIKE ?  and ville LIKE ?","#{params[:nom]}%","#{params[:ville]}%"], :order=>"nom asc")
   elsif params[:pays]!=""
     #nom_pay=Pay.find(params[:pays]).nom
      @clients=params[:etat]!=""? Client.find(:all,:conditions=>["nom LIKE ? and is_active= ? and pay_id=? and ville LIKE ?","#{params[:nom]}%",@test,params[:pays],"#{params[:ville]}%"], :order=>"nom asc"):
        Client.find(:all,:conditions=>["nom LIKE ? and pay_id=? and ville LIKE ?","#{params[:nom]}%",params[:pays],"#{params[:ville]}%"], :order=>"nom asc")
   else
      @clients = Client.all
    end
    
    render :partial=>"index" 
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
       @client.nom=@client.nom.force_encoding("UTF-8")
      @client.ville=@client.ville.force_encoding("UTF-8")
      @client.address=@client.address.force_encoding("UTF-8")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:code, :nom, :phone, :address, :ville, :pay_id,:is_active)
    end
end
