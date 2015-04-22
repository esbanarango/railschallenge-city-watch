module ActsAsApi
  class Responder < ActionController::Responder
    def json_resource_errors
      { message: resource.errors }
    end

    protected

    def api_behavior(*args, &block)
      if put? || patch?
        display resource, status: :ok
      else
        super
      end
    end
  end
end
