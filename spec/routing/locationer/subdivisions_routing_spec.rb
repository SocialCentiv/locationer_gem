require "spec_helper"

module Locationer
  describe SubdivisionsController do
    routes { Locationer::Engine.routes }

    describe "routing" do
      #only: [:show]

      it "'GET  /subdivisions/:id' routes to #show" do
        get("/subdivisions/2").should route_to("locationer/subdivisions#show", id: "2")
      end

    end
  end  
end

