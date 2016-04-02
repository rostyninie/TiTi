class TypeProduit < ActiveRecord::Base
  
  has_many :produits
  validates_uniqueness_of :code,:message => "le code doit être unique"
  before_save :set_is_active
   scope :active,-> { where(is_active: true) }
  scope :inactive, :conditions => { :is_active => false }
  def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
    
  end
  
end
