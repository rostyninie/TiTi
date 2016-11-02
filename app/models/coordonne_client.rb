class CoordonneClient < ActiveRecord::Base
  belongs_to :coordonne_bancaire
  belongs_to :client
end
