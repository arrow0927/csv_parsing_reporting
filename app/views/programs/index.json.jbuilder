json.array!(@programs) do |program|
  json.extract! program, 
  json.url program_url(program, format: :json)
end
