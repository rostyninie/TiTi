json.array!(@groupes) do |groupe|
  json.extract! groupe, :id, :nom, :code, :description
  json.url groupe_url(groupe, format: :json)
end
