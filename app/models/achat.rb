class Achat < ActiveRecord::Base
  belongs_to :produit
  belongs_to :fournisseur
  belongs_to :user
  has_one :transaction
  has_many :unique_produits
  has_many :valorisations
  has_many :frai_achats
  has_many :mouvement_stocks
  has_many :commande_produits
  has_one :precedent, :foreign_key =>"previous_id", :class_name => "Achat"
  has_one :suivant, :foreign_key =>"next_id", :class_name => "Achat"
 # scope :precedent, :conditions => {:previous_id=>nil} 
  #scope :suivant, :conditions => {:next_id=>nil} 
  validates_uniqueness_of :code,:message=>": impossible d'enregistrer l'achat, ce code existe déja pour un achat"
  before_create :set_is_active
  before_create :set_prev if Option.get_config_value('mode')=='2' || Option.get_config_value('mode')=='5'
  after_create :set_next if Option.get_config_value('mode')=='2' || Option.get_config_value('mode')=='5'
  
    def set_is_active
    if self.is_deleted.nil?
      self.is_deleted=1
    end
     if self.is_active.nil?
      if Option.get_config_value('mode')=='2' || Option.get_config_value('mode')=='5' 
      if Achat.all(conditions: {produit_id: self.produit_id, is_active: true}).count ==0
         self.is_active=1
      end
         
      end
    end
  end
  
    def set_prev
     
      if Achat.count!=0
         achat=Achat.all(conditions: {produit_id: self.produit_id, is_active: true}).first
         unless achat.nil?
           while !achat.next_id.nil?
             achat=Achat.find_by_id(achat.next_id)
           end
           if self.previous_id.nil?
           self.previous_id=achat.id
           end
         end
      end
    end
    
    
    def set_next
     
      if Achat.count!=0
#         achats=Achat.all(conditions: {produit_id: self.produit_id, is_active: true, next_id: nil})
#         achat=nil
#         achats.each do |ach|
#           if ach.id!=self.id
#           achat=ach
#           end
#           break
#         end
        achat=Achat.find_by_id(self.previous_id)
        unless achat.nil?
          if achat.next_id.nil?
           achat.next_id=self.id
           achat.save
          end
         end
      end
    end
end
