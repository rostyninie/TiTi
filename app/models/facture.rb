class Facture < ActiveRecord::Base
  belongs_to :commande
  belongs_to :client
end
