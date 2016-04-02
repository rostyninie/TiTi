json.array!(@commandes) do |commande|
  json.extract! commande, :id, :code, :montant, :en_cour, :client_id, :date_reglage, :is_deleted
  json.url commande_url(commande, format: :json)
end
