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
  class Subdivision < Location
    include LocationHelper
    FEATURE_CODE_SUBDIV = "ADM1"

    belongs_to :country, foreign_key: "country_code", primary_key: "country_code"
    has_many :cities, foreign_key: "admin1_code", primary_key: "admin1_code"

    default_scope {where(feature_code:FEATURE_CODE_SUBDIV)}

  end  
end



