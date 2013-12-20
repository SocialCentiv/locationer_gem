require_dependency "locationer/application_controller"

module Locationer
  class CountriesController < ApplicationController
    respond_to :json 

    def show
      @country = Country.find_by_id(params[:id])

      respond_with(@country) do |format|
        if @country.nil?
          format.json { render json: { success: false,
            errors:  ["Record not found"]}, status: 404}     
        else
          format.json { render json: CountryJsonDecorator.new(@country).to_json}
        end
      end       
    end

  end
end
