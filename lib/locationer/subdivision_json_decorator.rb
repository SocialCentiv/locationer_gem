
module Locationer
  class SubdivisionJsonDecorator
    def initialize(subdivision)
      @subdivision = subdivision
    end

    def name
      @subdivision.asciiname.capitalize_phrase
    end

    def code
      @subdivision.admin1_code
    end

    def country_id
      @subdivision.country.id
    end

    def to_json
      { id: @subdivision.id,
        code: self.code,
        country_id: self.country_id}.to_json
    end
  end
end