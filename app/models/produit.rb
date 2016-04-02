class Produit < ActiveRecord::Base
   belongs_to :rayon
   belongs_to :type_produit
   has_many :achats
   has_many :achat_histories
   has_many :commande_produit
  validates_format_of     :quantite_stock, :with => /\A[0-9]*\Z/i,   :allow_blank=>true,
    :message => " invalide!!! veillez entrer un nombre"
  validates_format_of     :quantite_gros, :with => /\A[0-9]*\Z/i,   :allow_blank=>true,
    :message => " invalide!!! veillez entrer un nombre"
  validates_format_of     :prix_gros, :with => /\A[0-9.]*\Z/i,   :allow_blank=>true,
    :message => " invalide!!! veillez entrer un nombre"
  validates_format_of     :prix_vente, :with => /\A[0-9.]*\Z/i,   :allow_blank=>true,
    :message => " invalide!!! veillez entrer un nombre"
  scope :active,-> { where(is_active: true) }
  scope :inactive, :conditions => { :is_active => false }
  before_save :set_is_active
   def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
  end
end
