
module Locationer
  class CountryJsonDecorator
    def self.countries_to_json(countries)
      (countries.collect {|country| self.new(country).to_hash}).to_json
    end

    def initialize(country)
      @country = country
    end

    def name
      @country.asciiname.capitalize_phrase
    end

    def code
      @country.country_code
    end

    def to_hash
      { id: @country.id,
        name: self.name,
        code: self.code}
    end    

    def to_json
      to_hash.to_json
    end
  end
end