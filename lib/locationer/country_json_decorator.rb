
module Locationer
  class CountryJsonDecorator
    def initialize(country)
      @country = country
    end

    def name
      @country.asciiname.capitalize_phrase
    end

    def code
      @country.country_code
    end

    def to_json
      { id: @country.id,
        name: self.name,
        code: self.code}.to_json
    end
  end
end