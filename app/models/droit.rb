class Droit < ActiveRecord::Base
   has_many :groupe_droit
  belongs_to :category
  before_save :set_is_active
    validates_uniqueness_of :code,:message => "le code doit être unique"
  validates_presence_of :code,:name,:message => "le nom ne doit pas être vide"
  validates_presence_of :category_id,:message => "veuillez choisir la catégorie du droit!!!"
  def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
    
  end
end
