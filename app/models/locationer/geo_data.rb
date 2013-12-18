# == Schema Information
#
# Table name: locationer_geo_data
#
#  id         :integer          not null, primary key
#  country    :string(255)
#  city_name  :string(255)
#  state      :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime
#  updated_at :datetime
#

# module Locationer
#   class GeoData < ActiveRecord::Base
#     #attr_accessible :country, :city_name, :latitude, :longitude, :state
#   end
# end
