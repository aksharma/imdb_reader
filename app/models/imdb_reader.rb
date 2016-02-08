class ImdbReader

  include Fetch

  def initialize(s,num_of_pages=1)
    num_of_pages.times do |page|
      arr = search(s,page+1)
      build_page(arr)
    end
  end

  def build_page(arr)
    arr.each do |entry|
      movie = Movie.find_or_initialize_by(imdbId: entry['imdbID'])
      unless movie.id
        movie.title = entry['Title']
        movie.director = entry['Director']
        movie.plot = entry['Plot']
        movie.rating = entry['imdbRating']
        movie.save
      end
      actors = entry['Actors'] || ''
      load_actors(movie,actors)
    end
  end

  def load_actors(movie,actors)
    arr = actors.split(',').map(&:strip)
    arr.each do |entry|
      actor = Actor.find_or_initialize_by(name: entry)
      actor.save unless actor.id
      actor.movies << movie
    end
  end
end
