class CommandeProduit < ActiveRecord::Base
  belongs_to :commande
  belongs_to :produit
end
