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
  factory :locationer_city, :class => 'Locationer::City' do
    feature_class "P"

    trait :st_louise do
      name "st. louis"
      asciiname "st. louis"
      latitude 38.62
      longitude -90.19
      feature_code "PPLA2"
      country_code "US"
      admin1_code "MO"
      population 319294
      timezone "America/Chicago"      
    end    

    trait :lake_saint_louise do
      name "lake saint louis"
      asciiname "lake saint louis"
      latitude 38.79
      longitude -90.78
      feature_code "PPL"
      country_code "US"
      admin1_code "MO"
      population 14545
      timezone "America/Chicago"      
    end      

    trait :dallas do
      name "dallas"
      asciiname "dallas"
      alternatenames "dfw,dalas,dalasa,dalasas"
      latitude 32.78306
      longitude -96.80667
      feature_code "PPLA2"
      country_code "US"
      admin1_code "TX"
      population 1197816
      timezone "America/Chicago"      
    end

    #3.03 miles from dallas
    trait :oak_cliff do
      name "oak cliff"
      asciiname "oak cliff"
      latitude 32.7393
      longitude -96.81111
      feature_code "PPL"
      country_code "US"
      admin1_code "TX"
      population 0
      timezone "America/Chicago"
    end

    #5.48 miles from dallas
    trait :eagle_ford do
      name "eagle ford"
      asciiname "eagle ford"
      latitude 32.78485
      longitude -96.90084
      feature_code "PPL"
      country_code "US"
      admin1_code "TX"
      population 0
      timezone "America/Chicago"
    end

    #6.99 miles from dallas
    trait :westwood_park do
      name "westwood park"
      asciiname "westwood park"
      latitude 32.7018
      longitude -96.87806
      feature_code "PPL"
      country_code "US"
      admin1_code "TX"
      population 0
      timezone "America/Chicago"   
    end
  end
end



