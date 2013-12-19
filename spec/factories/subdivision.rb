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
  factory :locationer_subdivision, :class => 'Locationer::Subdivision' do
    feature_class "A"
    feature_code "ADM1"

    trait :ca do
      name "california"
      asciiname "california"
      alternatenames "akeehashiih hahoodzo,akééháshį́į́h hahoodzo,alta california,ca"
      latitude 37.25022
      longitude -119.75126
      country_code "US"
      admin1_code "CA"
      population 37691912
      timezone "America/Los_Angeles"
    end   

    trait :tx do
      name "texas"
      asciiname "texas"
      alternatenames "akalii bikeyah,akałii bikéyah,estado de texas,estado de la estrella solitaria"
      latitude 31.25044
      longitude -99.25061
      country_code "US"
      admin1_code "TX"
      population 22875689
      timezone "America/Chicago"
    end
  end
end


