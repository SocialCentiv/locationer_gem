
module Locationer
  class Subdivision < Location
    include LocationHelper
    FEATURE_CODE_SUBDIV = "ADM1"

    belongs_to :country, foreign_key: "country_code", primary_key: "country_code"
    has_many :cities, foreign_key: "admin1_code", primary_key: "admin1_code"

    default_scope {where(feature_code:FEATURE_CODE_SUBDIV)}

  end  
end



