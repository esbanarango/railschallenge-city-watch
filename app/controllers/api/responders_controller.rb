module API
  class RespondersController < ApplicationController
    before_action :set_responder, only: [:show, :update]

    # GET api/v1/responders.json
    def index
      @responders = Responder.all
      respond_with :api, @responder, api_template: options[:api_template], meta: meta_datad
    end

    # PATCH/PUT api/v1/responders/1.json
    def show
      respond_with :api, @responder, api_template: :default
    end

    # POST api/v1/responders.json
    def create
      @responder = Responder.new(responder_params(:create))
      @responder.save
      respond_with :api, @responder, api_template: :default
    end

    # PATCH/PUT api/v1/responders/1.json
    def update
      @responder.update(responder_params)
      respond_with :api, @responder, api_template: :default
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_responder
      @responder = Responder.find_by(name: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def responder_params(action = :update)
      permitted =
        if action == :update
          [:on_duty]
        else
          [:capacity, :type, :name]
        end
      params.require(:responder).permit(permitted)
    end
  end
end
