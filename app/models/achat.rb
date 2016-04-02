class Achat < ActiveRecord::Base
  belongs_to :produit
  belongs_to :fournisseur
  belongs_to :user
  validates_uniqueness_of :code,:message=>": impossible d'enregistrer l'achat, ce code existe déja pour un achat"
  before_save :set_is_active
    def set_is_active
    if self.is_deleted.nil?
      self.is_deleted=1
    end
    
  end
end
