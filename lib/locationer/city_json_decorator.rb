
module Locationer
  class CityJsonDecorator
    def self.cities_to_json(cities)
      (cities.collect {|city| self.new(city).to_hash}).to_json
    end

    def initialize(city)
      @city = city
    end

    def name
      @city.asciiname.capitalize_phrase
    end

    def code
      @city.city_code
    end

    def to_hash
      { id: @city.id,
        name: self.name,
        subdivision_id: @city.subdivision.id
      }
    end

    def to_json
      to_hash.to_json
    end
  end
end

