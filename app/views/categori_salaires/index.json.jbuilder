json.array!(@categori_salaires) do |categori_salaire|
  json.extract! categori_salaire, :id, :code, :nom, :is_active
  json.url categori_salaire_url(categori_salaire, format: :json)
end
