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
#  admin1_code       :string(255)
#  population        :integer
#  timezone          :string(255)
#  modification_date :datetime
#


module Locationer
  class Location < ActiveRecord::Base
    def self.find_by_city_state(city,subdiviion)
      self.where(name: city).where(admin1_code: subdiviion)
    end
  end
end
