class Rayon < ActiveRecord::Base
  
  has_many :produits
  validates_uniqueness_of :code,:message => "le code doit être unique"
  before_save :set_is_active
  
  def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
    
  end
  
end
