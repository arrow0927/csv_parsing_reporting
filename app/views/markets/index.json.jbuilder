json.array!(@markets) do |market|
  json.extract! market, 
  json.url market_url(market, format: :json)
end
