class MouvementStock < ActiveRecord::Base
  belongs_to :achat
  belongs_to :produit
end
