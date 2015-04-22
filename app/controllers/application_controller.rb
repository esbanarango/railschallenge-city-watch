class ApplicationController < ActionController::API
  # Includes
  include ActionController::ImplicitRender
  include ActsAsApi::Rendering

  # Responders
  self.responder = ActsAsApi::Responder
  respond_to :json

  # Rescues
  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_parameters
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def routing_error
    render json: { message: 'page not found' }, status: :not_found
  end

  private

  def unpermitted_parameters(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end
end
