require 'spec_helper'

module Locationer
  describe CitiesController do
    routes { Locationer::Engine.routes }
    #only: :show

    # This should return the minimal set of attributes required to create a valid
    # cityTarget. As you add validations to cityTarget, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { {  } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # cityTargetsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      before(:each) do
        @texas = create :locationer_subdivision, :tx
        @dallas = create :locationer_city, :dallas
        @city_within_4_miles = create :locationer_city, :oak_cliff
        @city_within_6_miles = create :locationer_city, :eagle_ford
      end

      it "assigns the requested city as @city" do
        get :index, {:name => @dallas.asciiname, 
          :subdivision_code => @dallas.admin1_code,
          :country_code => @dallas.country_code,
          :radius => 5.0, :format => :json}, valid_session
        assigns(:city).should eq(@city)
      end

      it "should return json" do
        get :index, {:name => @dallas.asciiname, 
          :subdivision_code => @dallas.admin1_code,
          :country_code => @dallas.country_code,
          :radius => 5.0, :format => :json}, valid_session
        response.body.should eql("[{\"id\":#{@dallas.id},\"name\":\"Dallas\",\"subdivision_id\":#{@dallas.subdivision.id}},{\"id\":#{@city_within_4_miles.id},\"name\":\"Oak Cliff\",\"subdivision_id\":#{@city_within_4_miles.subdivision.id}}]")
      end      
    end  
  end
end


