require_dependency "locationer/application_controller"

module Locationer
  class CountriesController < ApplicationController
    respond_to :json 

    def show
      @country = Country.find_by_id(params[:id])

      respond_with(CountryJsonDecorator.new(@country).to_json)
    end

  end
end
