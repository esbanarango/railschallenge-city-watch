module Responses
  module Responder
    extend ActiveSupport::Concern
    included do
      acts_as_api
      api_accessible :default do |t|
        t.add :emergency_code
        t.add :type
        t.add :name
        t.add :capacity
        t.add :on_duty
      end
    end
  end
end
