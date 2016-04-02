json.array!(@options) do |option|
  json.extract! option, :id, :config_key, :config_value
  json.url option_url(option, format: :json)
end
