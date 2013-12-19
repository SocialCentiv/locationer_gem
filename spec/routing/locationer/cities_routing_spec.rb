require "spec_helper"

module Locationer
  describe CitiesController do
    routes { Locationer::Engine.routes }

    describe "routing" do
      #only: [:index]

      it "'GET  /cities' routes to #index" do
        get("/cities").should route_to("locationer/cities#index")
      end

    end
  end  
end

