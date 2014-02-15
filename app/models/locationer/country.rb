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
  class Country < Location
    include LocationHelper
    
    has_many :subdivisions, foreign_key: "country_code", primary_key: "country_code"
    has_many :cities, foreign_key: "country_code", primary_key: "country_code"

    FEATURE_CODE_COUNTRY = "PCLI"

    default_scope {where(feature_code:FEATURE_CODE_COUNTRY)}
  end  
end



