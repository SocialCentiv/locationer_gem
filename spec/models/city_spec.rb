require "spec_helper"

module Locationer
  describe City do
    describe ".find_nearby_cities_around" do
      before(:each) do
        @city_finder_mock = double("CityFinder instance")
        @city_finder_args = [{:subdivision=>"TX", :range=>5, :city=>"dallas"}]
        @args = ["dallas", "subdivision_code" => "TX",
          "country_code" => "US",
          "radius" => 5]
      end

      it "should call CityFinder#nearby_cities" do
        @city_finder_mock.should_receive(:nearby_cities).with(*@city_finder_args)
        CityFinder.stub(:new).with("US").and_return(@city_finder_mock)
        
        City.find_nearby_cities_around(*@args)
      end           
    end
  end
end


