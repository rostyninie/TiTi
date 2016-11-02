class CoordonneBancaire < ActiveRecord::Base
  has_many :coordonne_clients
  has_many :coordonne_fournisseurs
  validates_uniqueness_of :nom ,:message =>"impossible d'enregistrer: Le nom du coordonné existe déjà !!! "
  validates_uniqueness_of :code ,:message =>"impossible d'enregistrer: Le code du coordonné existe déjà !!! "
  scope :active,-> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  before_save :set_is_active
  before_save :up_case_nom
   def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
    
  end
  
   def up_case_nom
     self.nom=self.nom.upcase
   end
end
