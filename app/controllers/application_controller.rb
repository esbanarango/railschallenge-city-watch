class ApplicationController < ActionController::API

  include ActionController::ImplicitRender
  include ActsAsApi::Rendering

  self.responder = ActsAsApi::Responder
  respond_to :json

end