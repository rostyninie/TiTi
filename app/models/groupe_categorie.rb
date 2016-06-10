class GroupeCategorie < ActiveRecord::Base
  belongs_to :groupe
  belongs_to :category
end
