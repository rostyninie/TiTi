class Transaction < ActiveRecord::Base
  belongs_to :achat
  belongs_to :commande
end
