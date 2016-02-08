module Fetch
  def search(s,page)
    url1 = "http://www.omdbapi.com/?y=&plot=short&r=json&s=#{s}&page=#{page}"
    resp1 = Typhoeus.get(url1, followlocation: true)
    json1 = JSON.parse(resp1.body)
    arr = json1['Search']
    arr.map do |entry|
      url2 = "http://www.omdbapi.com/?plot=short&r=json&i=#{entry['imdbID']}"
      resp2 = Typhoeus.get(url2, followlocation: true)
      json2 = JSON.parse(resp2.body)
      entry.merge(json2)
    end
  end
end
