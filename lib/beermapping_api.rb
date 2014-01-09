class BeermappingAPI
  def self.places_in(city)
    Place # varmistaa, että luokan koodi on ladattu
    city = city.downcase
    Rails.cache.write city, fetch_places_in(city), :expires_in => 1.hour if not Rails.cache.exist? city

    Rails.cache.read city
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end
  
  def self.fetch_locquery(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/"

    response = HTTParty.get "#{url}#{id}"
    data = response.parsed_response["bmp_locations"]["location"]

    return nil if data['id']=="0" 

    
    Place.new(data)
    
  end

  def self.fetch_score(id)
    
    url = "http://beermapping.com/webservice/locscore/#{key}/"
    response = HTTParty.get "#{url}#{id}"
    scores = response.parsed_response["bmp_locations"]["location"]

    
    scores['overall'].to_f    

  end

  def self.key
    Settings.beermapping_apikey
  end
end