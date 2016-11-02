class UniqueProduit < ActiveRecord::Base
  belongs_to :achat
  belongs_to :produit
  has_one :commande_produit
  validates_uniqueness_of :code,:message=>": impossible d'enregistrer ce produit. le code du produit existe déjà!!!"
   before_create :set_is_non_solde
   
   def set_is_non_solde
    if self.etat.nil?
      self.etat=0
    end
   end
end
