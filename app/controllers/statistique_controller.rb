class StatistiqueController < ApplicationController
  def index
  end

  def index_bilan
  end

  def index_analyse
  end
  
  def bilan_by_periode
    @sorties=Transaction.find_all_by_is_deduc(true)
    @entrees=Transaction.find_all_by_is_add(true)
    @factures=Facture.find_all_by_is_solde(true) 
    # render :partial => "list_transaction"
  end
  
  def list_valorisation
    if params[:mode]=="cumpe"
      @valorisations=Valorisation.where(type_valorisation: "cumpe",produit_id: params[:produit_id])
    elsif params[:mode]=="cumpp"
      @valorisations = Valorisation.where(type_valorisation: "cumpp",produit_id: params[:produit_id])
    end
    
    render :partial => "list_valorisation"
  end
  
  def last_valorisation
    render :partial => "last_valorisation"
  end
  
  def valorisation_entree
   
    @valorisations=Valorisation.where(type_valorisation: "cumpe")
    @valorisation= @valorisations.last
    @produits=Produit.active
    unless @valorisation.nil?
      @produit=Produit.find_by_id(@valorisation.produit_id)
      @last_achat=Achat.find_by_id(@valorisation.achat_id)
      @init_achat= Achat.find_by_id(@valorisation.stock_initial)
      @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
      @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
      #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
      @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
      etat=false
      @tb_valorisation=[]
      quantite_s=0
      pu_s=0
      montant_s=0
      @tq_a=0
      @tq_o=0
      @tm_a=0
      @tm_o=0
      @mouvements.each_with_index do |t,i| 
        if t.type_mouvement=="entree" 
          #entree 
      
          date=t.date.to_date
          quantite_a=t.quantite.to_s
          @tq_a=@tq_a + t.quantite
          pu_a=t.prix_u.to_s
          montant_a=(t.prix_u * t.quantite).to_s
          @tm_a=@tm_a + (t.prix_u * t.quantite)
          if i==0 
            quantite_s=t.quantite
            pu_s=t.prix_u
            montant_s=(t.prix_u * t.quantite)
            operation="#{"Stock initial n°"} #{t.achat.code}" 
          else 
            hold_montant=quantite_s*pu_s
            quantite_s=quantite_s + t.quantite
            pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
            montant_s=(quantite_s * pu_s)
            operation="#{"Entrée n°"} #{t.achat.code}" 
                
          end 
      
          @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
        else 
          #sortie 
          operation="#{"Sortie"}" 
          date=t.date.to_date
          quantite_o=t.quantite.to_s
          @tq_o=@tq_o + t.quantite
          pu_o=t.prix_u.to_s
          montant_o=(t.prix_u * t.quantite).to_s
          @tm_o=@tm_o + (t.prix_u * t.quantite)
          quantite_s=quantite_s - t.quantite
          pu_s=t.prix_u
          montant_s=(quantite_s * pu_s)
          
          @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
        end 
                
      end  
    end
   
   
  end

  #valorisations par période 
  #********************************************************************
  
  def valorisation_periode
   
    @valorisations=Valorisation.where(type_valorisation: "cumpp")
    @valorisation= @valorisations.last
    @produits=Produit.active
    unless @valorisation.nil?
      @produit=Produit.find_by_id(@valorisation.produit_id)
      @last_achat=Achat.find_by_id(@valorisation.achat_id)
      @init_achat= Achat.find_by_id(@valorisation.stock_initial)
      @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
      @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
      #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
      @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
      etat=false
      @tb_valorisation=[]
      quantite_s=0
      pu_s=0
      montant_s=0
      @tq_a=0
      @tq_o=0
      @tm_a=0
      @tm_o=0
      @mouvements.each_with_index do |t,i| 
        if t.type_mouvement=="entree" 
          #entree 
      
          date=t.date.to_date
          quantite_a=t.quantite.to_s
          @tq_a=@tq_a + t.quantite
          pu_a=t.prix_u.to_s
          montant_a=(t.prix_u * t.quantite).to_s
          @tm_a=@tm_a + (t.prix_u * t.quantite)
          if i==0 
            quantite_s=t.quantite
            pu_s=t.prix_u
            montant_s=(t.prix_u * t.quantite)
            operation="#{"Stock initial n°"} #{t.achat.code}" 
          else 
            # hold_montant=quantite_s*pu_s
            quantite_s=quantite_s + t.quantite
            # pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
            montant_s=(quantite_s * pu_s)
            operation="#{"Entrée n°"} #{t.achat.code}" 
                
          end 
      
          @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
        else 
          #sortie 
          operation="#{"Sortie"}" 
          date=t.date.to_date
          quantite_o=t.quantite.to_s
          @tq_o=@tq_o + t.quantite
          pu_o=t.prix_u.to_s
          montant_o=(t.prix_u * t.quantite).to_s
          @tm_o=@tm_o + (t.prix_u * t.quantite)
          quantite_s=quantite_s - t.quantite
          # pu_s=t.prix_u
          montant_s=(quantite_s * pu_s)
          
          @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
        end 
                
      end 
      @cump=(@tm_a/@tq_a).round(2)
    end
   
   
  end
  
  #********************************************************************
  
  
  
  def list_stock_initiales
    @stock_initailes=Achat.find_all_by_produit_id(params[:produit_id],:order=>"created_at ASC")
    render :partial => "list_stock_initiales"
  end
  
  def list_stock_initiales_periode
    @stock_initailes=Achat.find_all_by_produit_id(params[:produit_id],:order=>"created_at ASC")
    render :partial => "list_stock_initiales_periode"
  end

  def valoriser
    #  Achat.find_by_sql("select * from achats where id < 5 order by created_at DESC").first
    @produit=Produit.find_by_id(params[:produit_id])
    @last_achat=Achat.where(produit_id: params[:produit_id]).last
    @init_achat= Achat.find_by_id(params[:stock_init_id])
    @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
    @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
    #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
    @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
    etat=false
    @tb_valorisation=[]
    quantite_s=0
    pu_s=0
    montant_s=0
    @tq_a=0
    @tq_o=0
    @tm_a=0
    @tm_o=0
    @mouvements.each_with_index do |t,i| 
      if t.type_mouvement=="entree" 
        #entree 
      
        date=t.date.to_date
        quantite_a=t.quantite.to_s
        @tq_a=@tq_a + t.quantite
        pu_a=t.prix_u.to_s
        montant_a=(t.prix_u * t.quantite).to_s
        @tm_a=@tm_a + (t.prix_u * t.quantite)
        if i==0 
          quantite_s=t.quantite
          pu_s=t.prix_u
          montant_s=(t.prix_u * t.quantite)
          operation="#{"Stock initial n°"} #{t.achat.code}" 
        else 
          hold_montant=quantite_s*pu_s
          quantite_s=quantite_s + t.quantite
          pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
          montant_s=(quantite_s * pu_s)
          operation="#{"Entrée n°"} #{t.achat.code}" 
                
        end 
      
        @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
      else 
        #sortie 
        operation="#{"Sortie"}" 
        date=t.date.to_date
        quantite_o=t.quantite.to_s
        @tq_o=@tq_o + t.quantite
        pu_o=t.prix_u.to_s
        montant_o=(t.prix_u * t.quantite).to_s
        @tm_o=@tm_o + (t.prix_u * t.quantite)
        quantite_s=quantite_s - t.quantite
        pu_s=t.prix_u
        montant_s=(quantite_s * pu_s)
          
        @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
      end 
                
    end 
    @cump=pu_s
    render :partial => "valoriser"
  end
  
  
  def valoriser_periode
    #  Achat.find_by_sql("select * from achats where id < 5 order by created_at DESC").first
    @produit=Produit.find_by_id(params[:produit_id])
    @last_achat=Achat.find_by_id(params[:stock_finale_id])
    @init_achat= Achat.find_by_id(params[:stock_init_id])
    @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
    @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
    #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
    @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
    etat=false
    @tb_valorisation=[]
    quantite_s=0
    pu_s=0
    montant_s=0
    @tq_a=0
    @tq_o=0
    @tm_a=0
    @tm_o=0
    @mouvements.each_with_index do |t,i| 
      if t.type_mouvement=="entree" 
        #entree 
      
        date=t.date.to_date
        quantite_a=t.quantite.to_s
        @tq_a=@tq_a + t.quantite
        pu_a=t.prix_u.to_s
        montant_a=(t.prix_u * t.quantite).to_s
        @tm_a=@tm_a + (t.prix_u * t.quantite)
        if i==0 
          quantite_s=t.quantite
          pu_s=t.prix_u
          montant_s=(t.prix_u * t.quantite)
          operation="#{"Stock initial n°"} #{t.achat.code}" 
        else 
          # hold_montant=quantite_s*pu_s
          quantite_s=quantite_s + t.quantite
          # pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
          montant_s=(quantite_s * pu_s)
          operation="#{"Entrée n°"} #{t.achat.code}" 
                
        end 
      
        @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
      else 
        #sortie 
        operation="#{"Sortie"}" 
        date=t.date.to_date
        quantite_o=t.quantite.to_s
        @tq_o=@tq_o + t.quantite
        pu_o=t.prix_u.to_s
        montant_o=(t.prix_u * t.quantite).to_s
        @tm_o=@tm_o + (t.prix_u * t.quantite)
        quantite_s=quantite_s - t.quantite
        # pu_s=t.prix_u
        montant_s=(quantite_s * pu_s)
          
        @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
      end 
                
    end 
    @cump=(@tm_a/@tq_a).round(2)
    render :partial => "valoriser_periode"
  end
  
  
  def valide_valorisation
 
    @produit=Produit.find_by_id(params[:produit_id])
    @init_achat=Achat.find_by_id(params[:app_init_id])
    @last_achat=Achat.find_by_id(params[:app_last_id])
    @cump=params[:cump]
    @type_valo=params[:mode]
    @code="Valorisation|#{@produit.nom.force_encoding("UTF-8")}|#{@last_achat.code}|#{Time.now.strftime(("%d-%m-%y %H:%M"))}"
    @valorisation=Valorisation.new
    @valorisation.code=@code
    @valorisation.type_valorisation=@type_valo
    @valorisation.achat_id= @last_achat.id
    @valorisation.stock_initial=@init_achat.id
    @valorisation.produit_id=@produit.id
    @valorisation.save
    
    @produit.update_attribute(:cump,@cump)
    if @type_valo=="cumpe"
    redirect_to :controller=>"statistique",:action => "valorisation_entree"
    elsif @type_valo== "cumpp"
    redirect_to :controller=>"statistique",:action => "valorisation_periode"
    end
  end
  
  def view_valorisation
    
    
    @valorisation= Valorisation.find_by_id(params[:valorisation_id])
    unless @valorisation.nil?
      @produit=Produit.find_by_id(@valorisation.produit_id)
      @last_achat=Achat.find_by_id(@valorisation.achat_id)
      @init_achat= Achat.find_by_id(@valorisation.stock_initial)
      @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
      @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
      #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
      @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
      etat=false
      @tb_valorisation=[]
      quantite_s=0
      pu_s=0
      montant_s=0
      @tq_a=0
      @tq_o=0
      @tm_a=0
      @tm_o=0
      @mouvements.each_with_index do |t,i| 
        if t.type_mouvement=="entree" 
          #entree 
      
          date=t.date.to_date
          quantite_a=t.quantite.to_s
          @tq_a=@tq_a + t.quantite
          pu_a=t.prix_u.to_s
          montant_a=(t.prix_u * t.quantite).to_s
          @tm_a=@tm_a + (t.prix_u * t.quantite)
          if i==0 
            quantite_s=t.quantite
            pu_s=t.prix_u
            montant_s=(t.prix_u * t.quantite)
            operation="#{"Stock initial n°"} #{t.achat.code}" 
          else 
            hold_montant=quantite_s*pu_s
            quantite_s=quantite_s + t.quantite
            pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
            montant_s=(quantite_s * pu_s)
            operation="#{"Entrée n°"} #{t.achat.code}" 
                
          end 
      
          @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
        else 
          #sortie 
          operation="#{"Sortie"}" 
          date=t.date.to_date
          quantite_o=t.quantite.to_s
          @tq_o=@tq_o + t.quantite
          pu_o=t.prix_u.to_s
          montant_o=(t.prix_u * t.quantite).to_s
          @tm_o=@tm_o + (t.prix_u * t.quantite)
          quantite_s=quantite_s - t.quantite
          pu_s=t.prix_u
          montant_s=(quantite_s * pu_s)
          
          @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
        end 
                
      end  
    end
   
  end
 
  
  def view_valorisation_periode
    
    
    @valorisation= Valorisation.find_by_id(params[:valorisation_id])
    unless @valorisation.nil?
      @produit=Produit.find_by_id(@valorisation.produit_id)
      @last_achat=Achat.find_by_id(@valorisation.achat_id)
      @init_achat= Achat.find_by_id(@valorisation.stock_initial)
      @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
      @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
      #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
      @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
      etat=false
      @tb_valorisation=[]
      quantite_s=0
      pu_s=0
      montant_s=0
      @tq_a=0
      @tq_o=0
      @tm_a=0
      @tm_o=0
     @mouvements.each_with_index do |t,i| 
        if t.type_mouvement=="entree" 
          #entree 
      
          date=t.date.to_date
          quantite_a=t.quantite.to_s
          @tq_a=@tq_a + t.quantite
          pu_a=t.prix_u.to_s
          montant_a=(t.prix_u * t.quantite).to_s
          @tm_a=@tm_a + (t.prix_u * t.quantite)
          if i==0 
            quantite_s=t.quantite
            pu_s=t.prix_u
            montant_s=(t.prix_u * t.quantite)
            operation="#{"Stock initial n°"} #{t.achat.code}" 
          else 
            # hold_montant=quantite_s*pu_s
            quantite_s=quantite_s + t.quantite
            # pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
            montant_s=(quantite_s * pu_s)
            operation="#{"Entrée n°"} #{t.achat.code}" 
                
          end 
      
          @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
        else 
          #sortie 
          operation="#{"Sortie"}" 
          date=t.date.to_date
          quantite_o=t.quantite.to_s
          @tq_o=@tq_o + t.quantite
          pu_o=t.prix_u.to_s
          montant_o=(t.prix_u * t.quantite).to_s
          @tm_o=@tm_o + (t.prix_u * t.quantite)
          quantite_s=quantite_s - t.quantite
          # pu_s=t.prix_u
          montant_s=(quantite_s * pu_s)
          
          @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
        end 
                
      end 
      @cump=(@tm_a/@tq_a).round(2)  
    end
   
  end
  

  def print_valorisation_pdf
   
    @produit=Produit.find_by_id(params[:produit_id])
    @init_achat=Achat.find_by_id(params[:app_init_id])
    @last_achat=Achat.find_by_id(params[:app_last_id])
    @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
    @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
    #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
    @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
    etat=false
    @tb_valorisation=[]
    quantite_s=0
    pu_s=0
    montant_s=0
    @tq_a=0
    @tq_o=0
    @tm_a=0
    @tm_o=0
    @mouvements.each_with_index do |t,i| 
      if t.type_mouvement=="entree" 
        #entree 
      
        date=t.date.to_date
        quantite_a=t.quantite.to_s
        @tq_a=@tq_a + t.quantite
        pu_a=t.prix_u.to_s
        montant_a=(t.prix_u * t.quantite).to_s
        @tm_a=@tm_a + (t.prix_u * t.quantite)
        if i==0 
          quantite_s=t.quantite
          pu_s=t.prix_u
          montant_s=(t.prix_u * t.quantite)
          operation="#{"Stock initial n°"} #{t.achat.code}" 
        else 
          hold_montant=quantite_s*pu_s
          quantite_s=quantite_s + t.quantite
          pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
          montant_s=(quantite_s * pu_s)
          operation="#{"Entrée n°"} #{t.achat.code}" 
                
        end 
      
        @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
      else 
        #sortie 
        operation="#{"Sortie"}" 
        date=t.date.to_date
        quantite_o=t.quantite.to_s
        @tq_o=@tq_o + t.quantite
        pu_o=t.prix_u.to_s
        montant_o=(t.prix_u * t.quantite).to_s
        @tm_o=@tm_o + (t.prix_u * t.quantite)
        quantite_s=quantite_s - t.quantite
        pu_s=t.prix_u
        montant_s=(quantite_s * pu_s)
          
        @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
      end 
                
    end  
    
    
    render :pdf =>"Valorisation|#{@produit.nom.force_encoding("UTF-8")}|#{@last_achat.code}", page_size:  'A4'
  end
 
  
  def print_valorisation_periode_pdf
    
    @produit=Produit.find_by_id(params[:produit_id])
    @init_achat=Achat.find_by_id(params[:app_init_id])
    @last_achat=Achat.find_by_id(params[:app_last_id])
    @init_mouv=MouvementStock.find_by_achat_id_and_date(@init_achat.id,@init_achat.created_at)
    @last_mouv=MouvementStock.find_by_achat_id_and_date(@last_achat.id,@last_achat.created_at)
    #@init_achat= Achat.find_by_sql("select * from achats where id < #{@last_achat.id} and produit_id=#{@produit.id} order by created_at DESC").first
    @mouvements=MouvementStock.find_by_sql("select * from mouvement_stocks where id>= #{@init_mouv.id} and id<=#{@last_mouv.id} and produit_id=#{@produit.id}")
   
    etat=false
    @tb_valorisation=[]
    quantite_s=0
    pu_s=0
    montant_s=0
    @tq_a=0
    @tq_o=0
    @tm_a=0
    @tm_o=0
    @mouvements.each_with_index do |t,i| 
      if t.type_mouvement=="entree" 
        #entree 
      
        date=t.date.to_date
        quantite_a=t.quantite.to_s
        @tq_a=@tq_a + t.quantite
        pu_a=t.prix_u.to_s
        montant_a=(t.prix_u * t.quantite).to_s
        @tm_a=@tm_a + (t.prix_u * t.quantite)
        if i==0 
          quantite_s=t.quantite
          pu_s=t.prix_u
          montant_s=(t.prix_u * t.quantite)
          operation="#{"Stock initial n°"} #{t.achat.code}" 
        else 
          # hold_montant=quantite_s*pu_s
          quantite_s=quantite_s + t.quantite
          # pu_s=(((t.prix_u * t.quantite) +  hold_montant)/(quantite_s)).round(2)
          montant_s=(quantite_s * pu_s)
          operation="#{"Entrée n°"} #{t.achat.code}" 
                
        end 
      
        @tb_valorisation+=([[date.to_s,operation,quantite_a,pu_a,montant_a,0,0,0,quantite_s,pu_s,montant_s]])
      else 
        #sortie 
        operation="#{"Sortie"}" 
        date=t.date.to_date
        quantite_o=t.quantite.to_s
        @tq_o=@tq_o + t.quantite
        pu_o=t.prix_u.to_s
        montant_o=(t.prix_u * t.quantite).to_s
        @tm_o=@tm_o + (t.prix_u * t.quantite)
        quantite_s=quantite_s - t.quantite
        # pu_s=t.prix_u
        montant_s=(quantite_s * pu_s)
          
        @tb_valorisation+=([[date.to_s,operation,0,0,0,quantite_o,pu_o,montant_o,quantite_s,pu_s,montant_s]])
      end 
      
    end
    @cump=(@tm_a/@tq_a).round(2)
     render :pdf =>"Valorisation|#{@produit.nom.force_encoding("UTF-8")}|#{@last_achat.code}", page_size:  'A4'
  end
  
  def recherche_transaction
    @sorties=Transaction.find_by_sql("Select * from transactions where is_deduc=true and (date_transaction >= '#{params[:date_debut]}' and date_transaction <= '#{params[:date_fin]}' )")
    @entrees=Transaction.find_by_sql("Select * from transactions where is_add=true and (date_transaction >= '#{params[:date_debut]}' and date_transaction <= '#{params[:date_fin]}' )")
    @factures=Facture.find_by_sql("Select * from factures where is_solde=true and (date_facture >= '#{params[:date_debut]}' and date_facture <= '#{params[:date_fin]}' )")
    render :partial => "list_transaction"
  end
  
  
  
  def recherche_valorisation
    @valorisations=Valorisation.find_by_sql("Select * from valorisations WHERE (created_at >= '#{params[:date_debut]}' and created_at <= '#{params[:date_fin]}' and type_valorisation='#{params[:mode]}')")
    render :partial => "index"
  end
end
