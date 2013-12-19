
module Locationer
  class Subdivision < Location
    include LocationHelper
    FEATURE_CODE_SUBDIV = "ADM1"

    default_scope {where(feature_code:FEATURE_CODE_SUBDIV)}

  end  
end



