module API
  class EmergenciesController < ApplicationController
    before_action :set_emergency, only: [:show, :update]

    # GET emergencies.json
    def index
      @emergencies = Emergency.all
      respond_with :api, @emergencies, api_template: :default, meta: { full_responses: Emergency.full_responses }
    end

    # PATCH/PUT emergencies/:code.json
    def show
      respond_with :api, @emergency, api_template: :default
    end

    # POST emergencies.json
    def create
      @emergency = Emergency.new(emergency_params(:create))
      DispatcherService.new(@emergency).call if @emergency.save
      respond_with :api, @emergency, api_template: :default
    end

    # PATCH/PUT emergencies/:code.json
    def update
      @emergency.update(emergency_params)
      respond_with :api, @emergency, api_template: :default
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_emergency
      @emergency = Emergency.find_by!(code: params[:code])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emergency_params(action = :update)
      permitted = [:fire_severity, :police_severity, :medical_severity]
      permitted << :resolved_at if action == :update
      permitted << :code if action == :create
      params.require(:emergency).permit(permitted)
    end
  end
end
