require_dependency "locationer/application_controller"

module Locationer
  class CitiesController < ApplicationController
    respond_to :json
    
    def index
      validate_params
      @cities = City.find_nearby_cities_around(*converted_params) if @errors.empty?
      
      if @cities
        respond_with(CityJsonDecorator.cities_to_json(@cities))
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
