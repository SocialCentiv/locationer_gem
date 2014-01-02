
module Locationer
  class SubdivisionJsonDecorator
    def self.subdivisions_to_json(subdivisions)
      (subdivisions.collect {|subdivision| self.new(subdivision).to_hash}).to_json
    end

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

    def to_hash
      {
        id:         @subdivision.id,
        code:       self.code,
        country_id: self.country_id,
        name:       self.name
      }      
    end

    def to_json
      to_hash.to_json
    end
  end
end