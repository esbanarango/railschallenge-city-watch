class ApplicationController < ActionController::API

  # Includes
  include ActionController::ImplicitRender
  include ActsAsApi::Rendering

  # Responders
  self.responder = ActsAsApi::Responder
  respond_to :json

  # Rescues
  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_parameters

  private

  def unpermitted_parameters e
    render json: {message: e.message}, status: :unprocessable_entity
  end

end