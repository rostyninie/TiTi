json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :titre, :description, :montant, :achat_id, :commande_id, :is_deduc, :is_add, :date_transaction
  json.url transaction_url(transaction, format: :json)
end
