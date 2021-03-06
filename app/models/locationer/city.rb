# == Schema Information
#
# Table name: locationer_locations
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  asciiname         :string(255)
#  alternatenames    :text
#  latitude          :float
#  longitude         :float
#  feature_class     :string(255)
#  feature_code      :string(255)
#  country_code      :string(255)
#  admin1_code       :string(255)
#  population        :integer
#  timezone          :string(255)
#  modification_date :datetime
#

module Locationer
  class City < Location
    include LocationHelper

    belongs_to :country, foreign_key: "country_code", primary_key: "country_code"
    belongs_to :subdivision, foreign_key: "admin1_code", primary_key: "admin1_code"

    FEATURE_CLASS_CITY = "P"
    RADIUS_DEFAULT     = 0

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


