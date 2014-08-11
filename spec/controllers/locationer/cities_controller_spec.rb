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
      context "when the resource is found" do
        before(:each) do
          @texas = create :locationer_subdivision, :tx
          @dallas = create :locationer_city, :dallas
          @city_within_4_miles = create :locationer_city, :oak_cliff
          @city_within_6_miles = create :locationer_city, :eagle_ford
          @cities = City.find_nearby_cities_around("dallas",
            { "subdivision_code" => "TX",
              "country_code" => "US",
              "radius" => 5.0} )
             
        end

        it "assigns the requested cities as @cities" do
          get :index, {:name => @dallas.asciiname, 
            :subdivision_code => @dallas.admin1_code,
            :country_code => @dallas.country_code,
            :radius => 5.0, :format => :json}, valid_session
          assigns(:cities).should eq(@cities)
        end

        it "should return json" do
          get :index, {:name => @dallas.asciiname, 
            :subdivision_code => @dallas.admin1_code,
            :country_code => @dallas.country_code,
            :radius => 5.0, :format => :json}, valid_session
          response.body.should eql("[{\"id\":#{@dallas.id},\"name\":\"Dallas\",\"subdivision_id\":#{@dallas.subdivision.id}},{\"id\":#{@city_within_4_miles.id},\"name\":\"Oak Cliff\",\"subdivision_id\":#{@city_within_4_miles.subdivision.id}}]")
        end     

        it "should return status 200" do
          get :index, {:name => @dallas.asciiname, 
            :subdivision_code => @dallas.admin1_code,
            :country_code => @dallas.country_code,
            :radius => 5.0, :format => :json}, valid_session      
          
          response.status.should eql(200)  
        end 

        context "when radius is nil" do
          it "assigns the requested cities as center city only" do
            get :index, {:name => @dallas.asciiname, 
              :subdivision_code => @dallas.admin1_code,
              :country_code => @dallas.country_code, 
              :format => :json}, valid_session
            assigns(:cities).should eq([@dallas])
          end

          it "should return json for center city only" do
            get :index, {:name => @dallas.asciiname, 
              :subdivision_code => @dallas.admin1_code,
              :country_code => @dallas.country_code,
              :format => :json}, valid_session
            response.body.should eql("[{\"id\":#{@dallas.id},\"name\":\"Dallas\",\"subdivision_id\":#{@dallas.subdivision.id}}]")
          end              
        end

        context "when the city is mispelled" do
          before(:each) do
            @misspelled_dallas = "dalas"
            @cities = City.find_nearby_cities_around(@misspelled_dallas,
              { "subdivision_code" => "TX",
                "country_code" => "US",
                "radius" => 5.0} )
          end

          it "assigns the requested cities as @cities" do
            get :index, {:name => @misspelled_dallas, 
              :subdivision_code => @dallas.admin1_code,
              :country_code => @dallas.country_code,
              :radius => 5.0, :format => :json}, valid_session
            assigns(:cities).should eq(@cities)
          end

          it "should return json" do
            get :index, {:name => @misspelled_dallas, 
              :subdivision_code => @dallas.admin1_code,
              :country_code => @dallas.country_code,
              :radius => 5.0, :format => :json}, valid_session

            response.body.should eql("[{\"id\":#{@dallas.id},\"name\":\"Dallas\",\"subdivision_id\":#{@dallas.subdivision.id}},{\"id\":#{@city_within_4_miles.id},\"name\":\"Oak Cliff\",\"subdivision_id\":#{@city_within_4_miles.subdivision.id}}]")
          end     

          it "should return status 200" do
            get :index, {:name => @misspelled_dallas, 
              :subdivision_code => @dallas.admin1_code,
              :country_code => @dallas.country_code,
              :radius => 5.0, :format => :json}, valid_session      
            
            response.status.should eql(200)  
          end 

          context "when radius is nil" do
            it "assigns the requested cities as center city only" do
              get :index, {:name => @misspelled_dallas, 
                :subdivision_code => @dallas.admin1_code,
                :country_code => @dallas.country_code, 
                :format => :json}, valid_session
              assigns(:cities).should eq([@dallas])
            end

            it "should return json for center city only" do
              get :index, {:name => @misspelled_dallas, 
                :subdivision_code => @dallas.admin1_code,
                :country_code => @dallas.country_code,
                :format => :json}, valid_session
              response.body.should eql("[{\"id\":#{@dallas.id},\"name\":\"Dallas\",\"subdivision_id\":#{@dallas.subdivision.id}}]")
            end              
          end          
        end
      end

      context "when the resource is not found" do
        it "assigns the requested cities as nil" do
          get :index, {:name => "dallas", 
            :subdivision_code => "TX",
            :country_code => "US",
            :radius => 5.0, :format => :json}, valid_session
          assigns(:cities).should eq([])
        end

        it "should return json" do
          get :index, {:name => "dallas", 
            :subdivision_code => "TX",
            :country_code => "US",
            :radius => 5.0, :format => :json}, valid_session
          response.body.should eql("{\"success\":false,\"errors\":[\"Records not found\"]}")
        end     

        it "should return status 404" do
          get :index, {:name => "dallas", 
            :subdivision_code => "TX",
            :country_code => "US",
            :radius => 5.0, :format => :json}, valid_session   
          
          response.status.should eql(404)  
        end         
      end

      context "when the required params are not passed" do
        it "assigns the requested cities as nil" do
          get :index, {:format => :json}, valid_session
          assigns(:cities).should eq(nil)
        end

        it "should return json with errors" do
          get :index, {:format => :json}, valid_session
          response.body.should eql("{\"success\":false,\"errors\":[\"Required parameter of 'name' missing\",\"Required parameter of 'subdivision_code' missing\",\"Required parameter of 'country_code' missing\"]}")
        end     

        it "should return status 400" do
          get :index, {:format => :json}, valid_session   
          
          response.status.should eql(400)  
        end         
      end      
    end  
  end
end


