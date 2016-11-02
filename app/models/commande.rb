class Commande < ActiveRecord::Base
  belongs_to :user
  has_many :commande_produits
  belongs_to :client
  has_one :transaction
end
