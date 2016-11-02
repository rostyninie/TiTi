json.array!(@mouvement_stocks) do |mouvement_stock|
  json.extract! mouvement_stock, :id, :date, :type, :achat_id, :produit_id, :quantite, :prix_u
  json.url mouvement_stock_url(mouvement_stock, format: :json)
end
