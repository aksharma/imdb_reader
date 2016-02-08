module Fetch
  def search(s,page)
    url = url_for_search(s,page)
    arr = JSON.parse(get_data(url).body)['Search']
    merge_actors(arr)
  end

  private

  def url_for_search(s,page)
    "http://www.omdbapi.com/?y=&plot=short&r=json&s=#{s}&page=#{page}"
  end

  def url_for_id(id)
    "http://www.omdbapi.com/?plot=short&r=json&i=#{id}"
  end

  def get_data(url)
    Typhoeus.get(url, followlocation: true)
  end

  def merge_actors(arr)
    arr.map do |entry|
      url = url_for_id(entry['imdbID'])
      json = JSON.parse(get_data(url).body)
      entry.merge(json)
    end
  end
end
