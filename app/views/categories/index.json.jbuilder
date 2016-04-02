json.array!(@categories) do |category|
  json.extract! category, :id, :code, :nom, :description, :is_active
  json.url category_url(category, format: :json)
end
