json.array!(@coordonne_bancaires) do |coordonne_bancaire|
  json.extract! coordonne_bancaire, :id, :code, :nom, :is_active
  json.url coordonne_bancaire_url(coordonne_bancaire, format: :json)
end
