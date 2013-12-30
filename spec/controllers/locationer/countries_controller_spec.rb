require 'spec_helper'

module Locationer
  describe CountriesController do
    routes { Locationer::Engine.routes }
    #only: :show

    # This should return the minimal set of attributes required to create a valid
    # CountryTarget. As you add validations to CountryTarget, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { {  } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # CountryTargetsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      context "when the resource is found" do
        before(:each) do
          @country = create :locationer_country, :us
        end

        it "assigns the requested country as @country" do
          get :index, {:format => :json}, valid_session
          assigns(:countries).should eq([@country])
        end

        it "should return json" do
          get :index, {:format => :json}, valid_session
          response.body.should eql("[{\"id\":#{@country.id},\"name\":\"United States\",\"code\":\"US\"}]")
        end     

        it "should return status 200" do
          get :index, {:format => :json}, valid_session   
          
          response.status.should eql(200)  
        end          
      end
    end

    describe "GET show" do
      context "when the resource is found" do
        before(:each) do
          @country = create :locationer_country, :us
        end

        it "assigns the requested country as @country" do
          get :show, {:id => @country.id, :format => :json}, valid_session
          assigns(:country).should eq(@country)
        end

        it "should return json" do
          get :show, {:id => @country.id, :format => :json}, valid_session
          response.body.should eql("{\"id\":#{@country.id},\"name\":\"United States\",\"code\":\"US\"}")
        end     

        it "should return status 200" do
          get :show, {:id => @country.id, :format => :json}, valid_session        
          
          response.status.should eql(200)  
        end              
      end

      context "when the resource is not found" do

        it "assigns the requested country as nil" do
          get :show, {:id => 11, :format => :json}, valid_session
          assigns(:country).should eq(nil)
        end

        it "should return json" do
          get :show, {:id => 11, :format => :json}, valid_session
          response.body.should eql("{\"success\":false,\"errors\":[\"Record not found\"]}")
        end   

        it "should return status 404" do
          get :show, {:id => 11, :format => :json}, valid_session        
          
          response.status.should eql(404)  
        end                  
      end      
    end   
  end 
end
