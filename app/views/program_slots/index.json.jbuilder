json.array!(@program_slots) do |program_slot|
  json.extract! program_slot, 
  json.url program_slot_url(program_slot, format: :json)
end
