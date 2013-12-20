require "spec_helper"

module Locationer
  describe CityFinder do
    describe "#nearby_cities" do
      before(:each) do
        @texas = create :locationer_subdivision, :tx
        @dallas = create :locationer_city, :dallas
        @city_within_4_miles = create :locationer_city, :oak_cliff
        @city_within_6_miles = create :locationer_city, :eagle_ford    
        @city_finder = CityFinder.new("US")  
      end      

      it "should find only center city when range is nil" do
        @city_finder.nearby_cities(:city => "dallas", 
          :subdivision => "TX").should eql([@dallas])
      end

      it "should find only cities within 4 miles" do
        @city_finder.nearby_cities(:city => "dallas", 
          :subdivision => "TX", 
          :range => 4.0).should eql([@dallas, @city_within_4_miles])
      end

      it "should find only cities within 6 miles" do
        @city_finder.nearby_cities(:city => "dallas", 
          :subdivision => "TX", 
          :range => 6.0).should eql([@dallas, @city_within_4_miles, @city_within_6_miles])
      end      
    end
  end
end
