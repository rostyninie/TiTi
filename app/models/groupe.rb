class Groupe < ActiveRecord::Base
  has_many :users
  has_many :groupe_categories
  before_save :set_is_active
    validates_uniqueness_of :code,:message => "le code doit être unique"
  validates_presence_of :code,:nom,:message => "le nom ne doit pas être vide"
 
  def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
    
  end
end
