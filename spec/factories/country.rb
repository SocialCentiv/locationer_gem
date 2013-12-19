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

FactoryGirl.define do
  factory :locationer_country, :class => 'Locationer::Country' do
    feature_class "A"
    feature_code "PCLI" 
    admin1_code "00"
    population 112468855

    trait :mx do
      name "mexico"
      asciiname "mexico"
      alternatenames "estados unidos mexicanos,imekisikho" 
      latitude 23.0 
      longitude -102.0      
      country_code "MX"     
      population 112468855
    end   

    trait :us do
      name "united states"
      asciiname "united states"
      alternatenames "abd,aleaa-oko ti amerika,ameerika uehendriigid,ameerika Ühendriigid"
      latitude 39.76
      longitude -98.5
      country_code "US"
      population 310232863
    end
  end
end


