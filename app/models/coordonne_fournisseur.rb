class CoordonneFournisseur < ActiveRecord::Base
  belongs_to :coordonne_bancaire
  belongs_to :fournisseur
end
