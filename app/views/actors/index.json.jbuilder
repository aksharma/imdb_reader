json.array!(@actors) do |actor|
  json.extract! actor, :id, :name, :rating
  json.url actor_url(actor, format: :json)
end
