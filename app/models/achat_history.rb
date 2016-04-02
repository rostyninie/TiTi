class AchatHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :produit
end
