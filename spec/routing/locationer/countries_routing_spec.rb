require "spec_helper"

module Locationer
  describe CountriesController do
    routes { Locationer::Engine.routes }

    describe "routing" do
      #only: [:show]

      it "'GET  /countries/:id' routes to #show" do
        get("/countries/2").should route_to("locationer/countries#show", id: "2")
      end

    end
  end  
end

