json.array!(@factures) do |facture|
  json.extract! facture, :id, :num, :commande_id, :client_id, :montant, :is_solde, :date_facture
  json.url facture_url(facture, format: :json)
end
