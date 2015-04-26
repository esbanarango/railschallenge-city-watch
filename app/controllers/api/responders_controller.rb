module API
  class RespondersController < ApplicationController
    before_action :set_responder, only: [:show, :update]

    # GET responders.json
    def index
      if params[:show] == 'capacity'
        render json: CapacityReporter.new.call, status: :ok
      else
        @responders = Responder.all
        respond_with :api, @responders, api_template: :default
      end
    end

    # PATCH/PUT responders/:name.json
    def show
      respond_with :api, @responder, api_template: :default
    end

    # POST responders.json
    def create
      @responder = Responder.new(responder_params(:create))
      @responder.save
      respond_with :api, @responder, api_template: :default
    end

    # PATCH/PUT responders/:name.json
    def update
      @responder.update(responder_params)
      respond_with :api, @responder, api_template: :default
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_responder
      @responder = Responder.find_by!(name: params[:name])
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
