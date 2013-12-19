module Locationer
  class City < Location
    include LocationHelper

    FEATURE_CLASS_CITY = "P"
    RADIUS_DEFAULT = 10

    default_scope {where(feature_class:FEATURE_CLASS_CITY)}

    def self.find_nearby_cities_around(center_city, options = {})
      subdivision_code =  options.fetch("subdivision_code"){raise "subdivision_code missing"}
      country_code =      options.fetch("country_code"){"US"}
      radius =            options.fetch("radius"){RADIUS_DEFAULT}

      cf_options = city_finder_adapter(center_city.downcase, subdivision_code.upcase, radius)
      CityFinder.new(country_code.upcase).nearby_cities(cf_options)
    end

    private

    def self.city_finder_adapter(city, subdivision_code, radius)
      { subdivision: subdivision_code,
        range: radius,
        city: city}
    end
  end  
end


