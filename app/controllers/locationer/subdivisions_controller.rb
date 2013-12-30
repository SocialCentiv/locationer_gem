require_dependency "locationer/application_controller"

module Locationer
  class SubdivisionsController < ApplicationController
    respond_to :json 

    def index
      @subdivisions = Subdivision.all

      respond_with(@subdivisions) do |format|
        format.json { render json: SubdivisionJsonDecorator.subdivisions_to_json(@subdivisions)}
      end       
    end    

    def show
      @subdivision = Subdivision.find_by_id(params[:id])

      #respond_with(SubdivisionJsonDecorator.new(@subdivision).to_json)


      respond_with(@subdivision) do |format|
        if @subdivision.nil?
          format.json { render json: { success: false,
            errors:  ["Record not found"]}, status: 404}     
        else
          format.json { render json: SubdivisionJsonDecorator.new(@subdivision).to_json}
        end
      end      
    end
  end
end
