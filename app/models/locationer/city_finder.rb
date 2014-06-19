module Locationer
  class CityFinder
    DEFAULT_RANGE = 0
    FEATURE_CODE_COUNTRY = "PCLI"

    def initialize(country_code)
      @country = country_code
    end

    #options are  
    # => :city, :subdivision, :range 
    def nearby_cities(*options)
      attributes = options.extract_options!
      range = ( attributes.fetch(:range) { DEFAULT_RANGE } ).to_f
      if city = find_city_by(attributes)
        if range == 0
          [city]
        else
          Locationer::City.find_by_sql(cities_within_radius(city, range))
        end
      else
        []
      end
    end

    private

    def nearby_cities_query_string(city,range)
      <<-SQL
        SELECT * , (sqrt(pow((longitude - #{city.longitude}) * cos(#{city.latitude} * pi() / 180),2) + pow(latitude - #{city.latitude},2)) * pi() * 7926.38 / 360) as distance
        FROM locationer_locations 
        WHERE #{range_where_query_string(city,range)}
          AND feature_class = 'P' 
          AND feature_code LIKE 'PPL%'
        ORDER BY distance ASC
      SQL
    end

    def cities_within_radius(city,range)
      <<-SQL
        SELECT * , (sqrt(pow((longitude - #{city.longitude}) * cos(#{city.latitude} * pi() / 180),2) + pow(latitude - #{city.latitude},2)) * pi() * 7926.38 / 360) as distance
        FROM (#{cities_within_parimeter(city,range)}) AS ll 
        WHERE #{range_where_query_string(city,range)}
          AND feature_code LIKE 'PPL%'
        ORDER BY distance ASC
      SQL
    end    

    def range_where_query_string(city,range)
      "sqrt(pow((longitude - #{city.longitude}) * cos(#{city.latitude} * pi() / 180),2) + pow(latitude - #{city.latitude},2)) * pi() * 7926.38 / 360 <= #{range} "     
    end

    def cities_within_parimeter(city,range)
      <<-SQL
        SELECT * 
        FROM locationer_locations 
        WHERE longitude <= #{city.longitude + miles_to_longitude(range)}
          AND longitude >= #{city.longitude - miles_to_longitude(range)}
          AND latitude  <= #{city.latitude + miles_to_latitude(range)} 
          AND latitude  >= #{city.latitude - miles_to_latitude(range)} 
          AND feature_class = 'P' 
      SQL
    end

    def find_city_by(attributes)
      city_name = attributes.fetch(:city) { raise ArgumentError, 'No city name provided' }
      reference = Locationer::City.where("country_code = ? AND asciiname = ?", @country.upcase, city_name.downcase)
      reference = reference.where(admin1_code: attributes[:subdivision]) if attributes[:subdivision]
      reference = reference.where(feature_class: "P")
      reference.first
    end

    def miles_to_latitude(miles)
      miles.to_f / 68.0
    end

    def miles_to_longitude(miles)
      miles.to_f / 53.0
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
