json.array!(@categorie_droits) do |categorie_droit|
  json.extract! categorie_droit, :id, :categorie_id, :droit_id
  json.url categorie_droit_url(categorie_droit, format: :json)
end
