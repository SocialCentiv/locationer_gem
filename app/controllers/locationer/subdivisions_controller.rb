require_dependency "locationer/application_controller"

module Locationer
  class SubdivisionsController < ApplicationController
    respond_to :json 

    def show
      @subdivision = Subdivision.includes(:country).find_by_id(params[:id])

      respond_with(SubdivisionJsonDecorator.new(@subdivision).to_json)
    end
  end
end
