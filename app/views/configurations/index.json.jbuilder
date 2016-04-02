json.array!(@configurations) do |configuration|
  json.extract! configuration, :id, :config_key, :config_value
  json.url configuration_url(configuration, format: :json)
end
