class Valorisation < ActiveRecord::Base
  belongs_to :achat
  belongs_to :produit
end
