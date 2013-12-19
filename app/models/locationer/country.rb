
module Locationer
  class Country < Location
    include LocationHelper
    
    FEATURE_CODE_COUNTRY = "PCLI"

    default_scope {where(feature_code:FEATURE_CODE_COUNTRY)}
  end  
end



