json.array!(@demos) do |demo|
  json.extract! demo, 
  json.url demo_url(demo, format: :json)
end
