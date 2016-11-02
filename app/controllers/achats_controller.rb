class AchatsController < ApplicationController
  before_filter :login_required
  before_filter :message_user
  filter_access_to :all
  before_action :set_frai, only: [:delete_frais, :update_frais, :edit_frais,:destroy_frais]
  before_action :set_achat, only: [:show, :edit, :update, :destroy]
  before_action :set_unique_produit, only: [:delete_unique, :edit_unique, :update_unique, :destroy_unique]

  # GET /achats
  # GET /achats.json
  def index
    #@achats = Achat.all(:order => "date_achat DESC")
    @achat = Achat.new
    @achats = Achat.all(:order => "date_achat DESC")
  end

  # GET /achats/1
  # GET /achats/1.json
  def show
  end

  # GET /achats/new
  def new
    @achat = Achat.new
  end

  # GET /achats/1/edit
  def edit
  end

  # POST /achats
  # POST /achats.json
  def create
    #@achats=Achat.all(:order => "date_achat DESC")
    
    #@achats=Achat.all
    @achat = Achat.create(achat_params)
    @achat.update_attribute(:date_achat,params[:achat][:date_achat])
    @achat.update_attribute(:prix_vente,params[:prix_vente])
    @achat.update_attribute(:etat_stock,@achat.quantite)
    @produit=Produit.find(@achat.produit_id)
    @achat.update_attribute(:quantite_stock_av,@produit.quantite_stock)
    quantite_stock=@produit.quantite_stock>0?(@achat.quantite+@produit.quantite_stock):@achat.quantite
    @produit.update_attribute(:quantite_stock,quantite_stock)
    @produit.update_attribute(:prix_vente,params[:prix_vente])
   # @produit.update_attribute(:prix_gros,(@produit.quantite_gros*@produit.prix_vente))
   @produit.update_attribute(:prix_gros,params[:prix_gros])
   if @produit.cump.nil?
     @produit.update_attribute(:cump,@achat.prix_achat_unitaire)
   end
    #mouvement de stock
    
    @mouvement_stock=MouvementStock.new
    #@mouvement_stock.date=Time.now.strftime("%d-%m-%Y %H:%M")
     @mouvement_stock.date=@achat.created_at
    @mouvement_stock.type_mouvement="entree"
    @mouvement_stock.achat_id=@achat.id
    @mouvement_stock.produit_id=@achat.produit.id
    @mouvement_stock.quantite= @achat.quantite

      @mouvement_stock.prix_u= @achat.prix_achat_unitaire
  
   @mouvement_stock.save
    
    
    #******************************************************************
   titre= "#{"achat de "} #{@achat.produit.nom}  #{" du "} #{@achat.date_achat.to_date}"
   montant=(@achat.quantite*@achat.prix_achat_unitaire) + @achat.marge_brut
   @transaction=Transaction.new(titre: titre,description: titre,montant: montant, achat_id: @achat.id,is_deduc: true, date_transaction: @achat.date_achat)
   @transaction.save
    flash[:notice]="Achat éffectué avec succès!!!"
    @achats = Achat.all(:order => "date_achat DESC")
    @achat=Achat.new
    #    respond_to do |format|
    #      if @achat.save
    #        format.html { redirect_to @achat, notice: 'Achat
    #         was successfully created.' }
    #        format.json { render action: 'show', status: :created, location: @achat }
    #      else
    #        format.html { render action: 'new' }
    #        format.json { render json: @achat.errors, status: :unprocessable_entity }
    #      end
    #    end
  end

  # PATCH/PUT /achats/1
  # PATCH/PUT /achats/1.json
  def update
    
    #@achats=Achat.all(:order => "date_achat DESC")
    #@achats=Achat.all
    ancien_quantite=@achat.quantite
    ancien_date_achat=@achat.date_achat
    ancien_marge=@achat.marge_brut
    ancien_code=@achat.code
    ancien_pu=@achat.prix_achat_unitaire
    ancien_user_id=@achat.user_id
    ancien_produit_id=@achat.produit_id
    ancien_prix_ht=@achat.prix_ht
    ancien_prix_vente=@achat.prix_vente
    ancien_cout_achat=@achat.cout_achat
    @produit=Produit.find(@achat.produit_id)
    if ancien_quantite<=@produit.quantite_stock
      @produit.update_attribute(:quantite_stock,(@produit.quantite_stock-ancien_quantite))
      
      @achat.update(achat_params)
      # @achat.update_attribute(:date_achat,params[:achat][:date_achat])
     # @achat.update_attribute(:prix_vente,params[:prix_vente])
      @achat.update_attribute(:etat_stock,@achat.quantite)
      @achat.save
      if Option.get_config_value('mode')=='4' || Option.get_config_value('mode')=='5'
        @uniques=@achat.unique_produits
        unless @uniques.nil?
        @uniques=@uniques.reject{|u| !u.groupe_id.nil?}
        @uniques.each do |u|
          u.update_attribute(:prix_vente, @achat.prix_vente)
        end
        end
      end
      #@produit=Produit.find(@achat.produit_id)
      quantite_stock=@produit.quantite_stock>0?(@achat.quantite+@produit.quantite_stock):@achat.quantite
      @produit.update_attribute(:quantite_stock,quantite_stock)
      if @achat.prix_vente
        @produit.update_attribute(:prix_vente,@achat.prix_vente)
       # @produit.update_attribute(:prix_gros,(@produit.quantite_gros*@produit.prix_vente))
       @produit.update_attribute(:prix_gros,params[:prix_gros])
        @produit.save
      end
      flash[:notice]="Achat modifier avec succès!!!"
      acha_hsto=AchatHistory.new
      acha_hsto.code=ancien_code
      acha_hsto.created_at=ancien_date_achat
      acha_hsto.marge_brut=ancien_marge
      acha_hsto.prix_achat_unitaire=ancien_pu
      acha_hsto.prix_ht=ancien_prix_ht
      acha_hsto.prix_vente=ancien_prix_vente
      acha_hsto.produit_id=ancien_produit_id
      acha_hsto.quantite=ancien_quantite
      acha_hsto.user_id=ancien_user_id
      acha_hsto.cout_achat = ancien_cout_achat
      acha_hsto.raison=params[:raison]
      acha_hsto.save
      acha_hsto.update_attribute(:date_achat,ancien_date_achat)
      @mouvement_stock=MouvementStock.find_by_achat_id_and_date(@achat.id,@achat.created_at)
      @mouvement_stock.update_attribute(:quantite,@achat.etat_stock)
      @mouvement_stock.update_attribute(:prix_u,@achat.prix_achat_unitaire)
      montant=(@achat.quantite*@achat.prix_achat_unitaire) + @achat.marge_brut
      @transaction=Transaction.find_by_achat_id(@achat.id)
      @transaction.update_attribute(:montant, montant)
      @achat=Achat.new
    else
      @achat.errors.add(:quantite, " : impossible de modifier cet achat car des ventes on déjà été éffectués sur l'ancienne quantité!!!")
    end
    @achats = Achat.all(:order => "date_achat DESC")
    
  end

  
  
  def achat_history
    @achat_histories=AchatHistory.find_all_by_produit_id_and_code(params[:id],params[:code],:order=>"date_achat DESC")
  end
  
  # DELETE /achats/1
  # DELETE /achats/1.json
  def destroy
    @achat.destroy
    respond_to do |format|
      format.html { redirect_to achats_url }
      format.json { head :no_content }
    end
  end

  def seach_product
    if params[:type_id]!=""
      @produits=Produit.find_all_by_type_produit_id(params[:type_id])
    else
      @produits=Produit.active
    end
    render :partial => "seach_product"
  end
  
  def recherche_achat
   
    nom_produit=""
    nom_fournisseur=""
    unless params[:produit_id]==""
      nom_produit=Produit.find_by_id(params[:produit_id]).nom 
    end
    unless params[:fournisseur_id]==""
      nom_fournisseur=Fournisseur.find_by_id(params[:fournisseur_id]).nom
    end
     
     
    
    if params[:date_debut]!="" || params[:date_fin]!="" || params[:produit_id]!="" || params[:fournisseur_id]!=""
      @achats=Achat.find_by_sql("SELECT achats.* FROM achats INNER JOIN produits on produits.id=achats.produit_id INNER JOIN fournisseurs on fournisseurs.id=achats.fournisseur_id where produits.nom like '#{nom_produit}%' and fournisseurs.nom like '#{nom_fournisseur}%' and achats.date_achat>='#{params[:date_debut]}' and achats.date_achat<='#{params[:date_fin]}' order by date_achat DESC")
    else
      #@achats = Achat.all(:order => "date_achat DESC")
      @achats = Achat.all(:order => "date_achat DESC")
    end
    
    render :partial=>"index" 
  end
  
  def active_app
    @achat = Achat.find(params[:id])
    if Option.get_config_value('mode')=='2' || Option.get_config_value('mode')=='5' 
      
      @active_achat = Achat.find_by_is_active_and_produit_id(true,@achat.produit_id)
     
      unless @active_achat.nil?
        @active_achat.update_attribute(:is_active, false)
        @active_achat.save
      end
      if @achat.is_active==false 
   if !@active_achat.nil?
     @achat.update_attribute(:is_active, true) unless @achat.id==@active_achat.id
   else
    @achat.update_attribute(:is_active, true) 
   end
        
        
      flash[:notice]="Approvisionement activé!!!"
      else
        @achat.update_attribute(:is_active, false)
      flash[:notice]="Approvisionement désactivé!!!"
      end
    else
      if @achat.is_active==false
      @achat.update_attribute(:is_active, true)
      flash[:notice]="Approvisionement activé!!!"
    else
       @achat.update_attribute(:is_active, false)
      flash[:notice]="Approvisionement désactivé!!!"
    end
      #flash[:notice]="Les approvisionements ne peuvent êtres activés qu'en mode FIFO ou LIFO!!! "
    end
    @achats = Achat.all(:order => "date_achat DESC")
  end
  
  def change_app
    old_activ_achat=Achat.find_by_produit_id_and_is_active(params[:id],true)
    fl_achat=nil
    @achat=nil
    #if Option.get_config_value('mode')=='2'
    if old_activ_achat.produit.mode=="fifo"
       fl_achat=old_activ_achat
      while !fl_achat.previous_id.nil?
        fl_achat=Achat.find_by_id(fl_achat.previous_id)
      end
      if fl_achat.etat_stock!=0
        @achat=fl_achat
        if old_activ_achat.id != @achat.id
        old_activ_achat.update_attribute(:is_active, false)
        old_activ_achat.save
        @achat.update_attribute(:is_active, true)
        @achat.save
        end
        flash[:notice]="Stock changer!!! nouveau stock :  "+@achat.code+" du "+@achat.date_achat.to_s
      else
        @achat=fl_achat
        while @achat.etat_stock==0 && !@achat.next_id.nil?
          @achat=Achat.find_by_id(@achat.next_id)
        end
         
        if @achat.etat_stock==0 
          flash[:notice]="pas de stock utilisable dans le magazin !!! "
        else
          if old_activ_achat.id != @achat.id
          old_activ_achat.update_attribute(:is_active, false)
          old_activ_achat.save
          @achat.update_attribute(:is_active, true)
          @achat.save
          end
          flash[:notice]="Stock changer!!! nouveau stock :  "+@achat.code+" du "+@achat.date_achat.to_s 
        end
      end
    #elsif  Option.get_config_value('mode')=='lifo' 
      elsif  old_activ_achat.produit.mode == 'lifo' 
       fl_achat=old_activ_achat
      while !fl_achat.next_id.nil?
        fl_achat=Achat.find_by_id(fl_achat.next_id)
      end
      if fl_achat.etat_stock!=0
        @achat=fl_achat
        if old_activ_achat.id != @achat.id
        old_activ_achat.update_attribute(:is_active, false)
        old_activ_achat.save
        @achat.update_attribute(:is_active, true)
        @achat.save
        end
        flash[:notice]="Stock changer!!! nouveau stock :  "+@achat.code+" du "+@achat.date_achat.to_s
      else
        @achat=fl_achat
        while @achat.etat_stock==0 && !@achat.previous_id.nil?
          @achat=Achat.find_by_id(@achat.previous_id)
        end
         
        if @achat.etat_stock==0 
          flash[:notice]="pas de stock utilisable dans le magazin !!! "
        else
          if old_activ_achat.id != @achat.id
          old_activ_achat.update_attribute(:is_active, false)
          old_activ_achat.save
          @achat.update_attribute(:is_active, true)
          @achat.save
           end
          flash[:notice]="Stock changer!!! nouveau stock :  "+@achat.code+" du "+@achat.date_achat.to_s 
        end
      end
    end
   @achats = Achat.all(:order => "date_achat DESC")
  end
  
  
  def add_unique_produit
    @achat=Achat.find(params[:id])
    @groupe=UniqueProduit.find_by_id(params[:groupe_id])
    unless @groupe.nil?
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,@groupe.id)
    else
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,nil)
    end
    @produit=@achat.produit
    @unique=UniqueProduit.new
  end
  
  def edit_unique
    
  end
  
  def create_unique
    
    @unique = UniqueProduit.create(unique_produit_params)
     @achat=Achat.find(@unique.achat_id)
    @groupe=UniqueProduit.find_by_id(@unique.groupe_id)
    unless @groupe.nil?
     @groupe.update_attribute(:prix_vente,0) if UniqueProduit.find_all_by_groupe_id(@groupe.id).count==1
    end
    @groupe.update_attribute(:prix_vente,@groupe.prix_vente + @unique.prix_vente) unless @groupe.nil?
    unless @groupe.nil?
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,@groupe.id)
    else
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,nil)
    end
      flash[:notice]="produit enregistré!!!"
    @produit=@achat.produit
    @unique=UniqueProduit.new
  end
  
  def update_unique
   @unique.update(unique_produit_params)
     @achat=Achat.find(@unique.achat_id)
    @groupe=UniqueProduit.find_by_id(@unique.groupe_id)
    unless @groupe.nil?
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,@groupe.id)
    else
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,nil)
    end
    flash[:notice]="produit modifié!!!"
    @produit=@achat.produit
    @unique=UniqueProduit.new
  end
  
  def delete_unique
    
  end
  
  def destroy_unique
    
    
    @achat=Achat.find(@unique.achat_id)
    @groupe=UniqueProduit.find_by_id(@unique.groupe_id)
    @produit=@achat.produit
    
  prix_v=@unique.prix_vente
    list_s_pr=UniqueProduit.find_all_by_groupe_id(@unique.id)
    if list_s_pr.count==0
      @unique.destroy
    if @unique.destroyed?
       flash[:notice]="produit supprimé!!!"
      
    @groupe.update_attribute(:prix_vente,@groupe.prix_vente - prix_v) unless @groupe.nil?
       
    end
    else
       
      flash[:notice]="impossible supprimé de supprimer ce produit!!! veillez supprimer ses sous produits avant"
      
    end
     unless @groupe.nil?
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,@groupe.id)
    else
      @list_unique=UniqueProduit.find_all_by_achat_id_and_groupe_id(@achat.id,nil)
    end
    @unique=UniqueProduit.new
  end
  
  def list_achat_pdf
    
     nom_produit=""
    nom_fournisseur=""
    unless params[:produit_id]==""
      @nom_produit=Produit.find_by_id(params[:produit_id]).nom 
    end
    unless params[:fournisseur_id]==""
      @nom_fournisseur=Fournisseur.find_by_id(params[:fournisseur_id]).nom
    end
     
     @debut=params[:date_debut]
    @fin=params[:date_fin]
    if params[:date_debut]!="" || params[:date_fin]!="" || params[:produit_id]!="" || params[:fournisseur_id]!=""
      @achats=Achat.find_by_sql("SELECT achats.* FROM achats INNER JOIN produits on produits.id=achats.produit_id INNER JOIN fournisseurs on fournisseurs.id=achats.fournisseur_id where produits.nom like '#{@nom_produit}%' and fournisseurs.nom like '#{@nom_fournisseur}%' and achats.date_achat>='#{params[:date_debut]}' and achats.date_achat<='#{params[:date_fin]}' ORDER BY date_achat DESC")
    else
      @achats = Achat.all(:order => "date_achat DESC")
    end
    
    
     render :pdf =>"Liste des approvisionnment du #{params[:date_debut].to_s} au #{params[:date_fin].to_s} produit #{nom_produit} Fournisseur #{nom_fournisseur}", page_size:  'A4' 
  end
  
  def achat_history_pdf
    @achat_histories=AchatHistory.find_all_by_produit_id_and_code(params[:produit_id],params[:code],:order=>"date_achat DESC")
     render :pdf =>"#{"Liste de modifications sur achat : "} #{@achat_histories.first.code} du produit : #{@achat_histories.first.produit.nom.force_encoding("UTF-8")}", page_size:  'A4' 

  end
  
  def faire_sortir
    @achat=Achat.find_by_code(params[:code_achat])
    @qt= @achat.sortie.nil? ? params[:quantite_sortie] : (@achat.sortie + (params[:quantite_sortie]).to_i)
    @achat.update_attribute(:sortie,@qt)
    @achat.update_attribute(:etat_stock,(@achat.etat_stock - (params[:quantite_sortie]).to_i))
    @achat.produit.update_attribute(:quantite_stock, (@achat.produit.quantite_stock - (params[:quantite_sortie]).to_i))
    
    @mouvement_stock=MouvementStock.new
    #@mouvement_stock.date=Time.now.strftime("%d-%m-%Y %H:%M")
     @mouvement_stock.date=Date.today
    @mouvement_stock.type_mouvement="sortie"
    @mouvement_stock.achat_id=@achat.id
    @mouvement_stock.produit_id=@achat.produit.id
    @mouvement_stock.quantite= params[:quantite_sortie]
    if Option.get_config_value('mode')=='1' || Option.get_config_value('mode')=='4'
      @mouvement_stock.prix_u= @achat.produit.cump
    elsif Option.get_config_value('mode')=='2' || Option.get_config_value('mode')=='5'
      @mouvement_stock.prix_u= @achat.prix_achat_unitaire
    end
   if @mouvement_stock.save
     @msg="#{(params[:quantite_sortie]).to_s} #{" Ont été sorties du stock "}  #{@achat.code}"
     @achats = Achat.all(:order => "date_achat DESC")
   end
  end
  
  def frais_app
    @list_frais=FraiAchat.where(achat_id: params[:id])
    @achat=Achat.find(params[:id])
    @frais=FraiAchat.new
  end
  
  def  create_frais
    @frai=FraiAchat.create(frais_params)
    @achat=Achat.find(@frai.achat_id)
    @new_prix=(((@achat.prix_achat_unitaire * @achat.quantite) + FraiAchat.where(achat_id: @achat.id).sum(:montant))/@achat.quantite)
    @achat.update_attribute(:cout_achat,@new_prix)
    @achat.update_attribute(:prix_revient,((@achat.prix_achat_unitaire * @achat.quantite) + FraiAchat.where(achat_id: @achat.id).sum(:montant)))
      @list_frais=FraiAchat.where(achat_id: @frai.achat_id)
  flash[:notice]="Frais enregistré avec succèss!!!"
    @frais=FraiAchat.new
    
  end
  
  def edit_frais
    
  end
  
  def update_frais
   
  end
  
  def delete_frais
   
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_achat
    @achat = Achat.find(params[:id])
  end
  private
   def set_unique_produit
    @unique = UniqueProduit.find(params[:id])
  end
  
   def set_frai
    @frai_achat = FraiAchat.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def achat_params
    params.require(:achat).permit(:code, :prix_achat_unitaire, :marge_brut, :prix_ht, :quantite, :date_achat, :user_id, :produit_id, :fournisseur_id,:prix_revient ,:prix_vente, :is_deleted, :cout_achat,:sortie)
  end
  
   def unique_produit_params
    params.require(:unique).permit(:code, :prix_vente, :groupe_id, :produit_id, :achat_id)
  end
  
   def frais_params
    params.require(:frai_achat).permit(:description, :montant, :achat_id)
  end
end
