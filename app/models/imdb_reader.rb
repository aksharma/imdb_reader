class ImdbReader
  def initialize(s,num_of_pages=1)
    num_of_pages.times do |page|
      build_page(s,page+1)
    end
  end

  def build_page(s,page)
    url = "http://www.omdbapi.com/?y=&plot=short&r=json&s=#{s}&page=#{page}"
    resp = Typhoeus.get(url, followlocation: true)
    json = JSON.parse(resp.body)
    arr = json['Search']
    arr.each do |entry|
      movie = Movie.where(imdbId: entry['imdbID'])[0]
      unless movie
        movie = Movie.new
        movie.title = entry['Title']
        movie.imdbId = entry['imdbID']
        load_details(movie)
      end
    end
  end

  def load_details(movie)
    url = "http://www.omdbapi.com/?plot=short&r=json&i=#{movie.imdbId}"
    resp = Typhoeus.get(url, followlocation: true)
    json = JSON.parse(resp.body)
    movie.director = json['Director']
    movie.plot = json['Plot']
    movie.rating = json['imdbRating']
    movie.save
    load_actors(movie,json)
  end

  def load_actors(movie,json)
    arr = json['Actors'].gsub(/ *, */, ',').split(',')
    arr.each do |entry|
      actor = Actor.find_or_initialize_by(name: entry)
      actor.save unless actor.id
      actor.movies << movie
    end
  end
end
