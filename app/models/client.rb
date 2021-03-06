class Client < ActiveRecord::Base
  belongs_to :pay
  has_many :commandes
  has_many :factures
  has_many :coordonne_clients
  validates_format_of     :phone, :with => /\A[0-9]{9}\Z/i,   :allow_blank=>true,
    :message => "téléphone invalide!!! exp : 655206994"
  #validates :code, presence: true
  scope :active,-> { where(is_active: true) }
  scope :inactive,-> { where(is_active: false) } 
  before_save :set_is_active
   def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
    
  end
end
