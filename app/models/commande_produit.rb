class CommandeProduit < ActiveRecord::Base
  belongs_to :commande
  belongs_to :produit
  belongs_to :achat
  has_one :unique_produits
end
