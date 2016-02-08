json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :director, :imdbId, :plot, :rating
  json.url movie_url(movie, format: :json)
end
