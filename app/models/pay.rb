class Pay < ActiveRecord::Base
  has_many :clients
  has_many :fournisseurs
end
