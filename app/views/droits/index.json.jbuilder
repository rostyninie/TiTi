json.array!(@droits) do |droit|
  json.extract! droit, :id, :name, :code, :description
  json.url droit_url(droit, format: :json)
end
