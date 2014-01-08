json.array!(@channels) do |channel|
  json.extract! channel, 
  json.url channel_url(channel, format: :json)
end
