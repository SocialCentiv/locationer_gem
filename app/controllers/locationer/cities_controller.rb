require_dependency "locationer/application_controller"

module Locationer
  class CitiesController < ApplicationController
    respond_to :json

    def index
      validate_params
      @cities = City.find_nearby_cities_around(*converted_params) if @errors.blank?

      respond_with(@cities) do |format|
        case
        when @cities.blank?
          if @errors.blank?
            #It should at least return the center city, 
            #but if @cities is empty then it means the center city was not
            #found either
            format.json { render json: { success: false,
              errors:  ["Records not found"]}, status: 404}     
          else
            format.json { render json: { success: false,
              errors: @errors}, status: 400} 
          end
        else
          format.json { render json: CityJsonDecorator.cities_to_json(@cities)}
        end
      end       
    end

    private

    def validate_params
      @errors = []
      @errors << "Required parameter of 'name' missing" unless params[:name]
      @errors << "Required parameter of 'subdivision_code' missing" unless params[:subdivision_code]
      @errors << "Required parameter of 'country_code' missing" unless params[:country_code]
    end

    def converted_params
      center_city = params.fetch(:name)
      subdivision_code = params.fetch(:subdivision_code)
      country_code = params.fetch(:country_code)
      radius = params.fetch(:radius){0.0}
      [center_city, {"subdivision_code" => subdivision_code,
        "country_code" => country_code,
        "radius" => radius}]
    end
  end
end
