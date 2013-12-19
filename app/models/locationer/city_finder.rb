module Locationer
  class CityFinder
    DEFAULT_RANGE = 10
    FEATURE_CODE_COUNTRY = "PCLI"

    def initialize(country_code)
      @country = country_code
    end

    def nearby_cities(*options)
      puts options.inspect
      attributes = options.extract_options!
      range = attributes.fetch(:range) { DEFAULT_RANGE }
      if city = find_city_by(attributes)
        Locationer::Location.find_by_sql(nearby_cities_query_string(city, range))
      else
        []
      end
    end

    private

    def nearby_cities_query_string(city,range)
      <<-SQL
        SELECT * 
        FROM locationer_locations 
        WHERE #{range_where_query_string(city,range)}
          AND feature_class = 'P' 
          AND feature_code LIKE 'PPL%'
      SQL
    end

    def range_where_query_string(city,range)
      "sqrt(pow((longitude - #{city.longitude}) * cos(#{city.latitude} * pi() / 180),2) + pow(latitude - #{city.latitude},2)) * pi() * 7926.38 / 360 <= #{range} "     
    end

    def find_city_by(attributes)
      city_name = attributes.fetch(:city) { raise ArgumentError, 'No city name provided' }
      reference = Locationer::Location.where("country_code = ? AND asciiname = ?", @country.upcase, city_name.downcase)
      reference = reference.where(admin1_code: attributes[:subdivision]) if attributes[:subdivision]
      reference = reference.where(feature_class: "P")
      reference.first
    end


    # DEFAULT_RANGE = 10

    # def initialize(country)
    #   @country = country || 'US'
    # end

    # def nearby_cities(*options)
    #   attributes = options.extract_options!
    #   range = attributes.fetch(:range) { DEFAULT_RANGE }
    #   if city = find_city_by(attributes)
    #     Locationer::GeoData.find_by_sql("select city_name, state from locationer_geo_data where sqrt(pow((longitude - #{city.longitude}) * cos(#{city.latitude} * pi() / 180),2) + pow(latitude - #{city.latitude},2)) * pi() * 7926.38 / 360 <= #{range}")
    #   else
    #     []
    #   end
    # end

    # private

    # def find_city_by(attributes)
    #   city_name = attributes.fetch(:city) { raise ArgumentError, 'No city name provided' }
    #   reference = Locationer::GeoData.where("lower(country) = ? AND lower(city_name) = ?", @country.downcase, city_name.downcase)
    #   reference = reference.where(state: attributes[:state]) if attributes[:state]
    #   reference.first
    # end
  end
end
