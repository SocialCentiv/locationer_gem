
module Locationer
  class Country < Location
    include LocationHelper
    
    has_many :subdivisions, foreign_key: "country_code", primary_key: "country_code"
    has_many :cities, foreign_key: "country_code", primary_key: "country_code"

    FEATURE_CODE_COUNTRY = "PCLI"

    default_scope {where(feature_code:FEATURE_CODE_COUNTRY)}
  end  
end



