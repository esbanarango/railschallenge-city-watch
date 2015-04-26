module Responses
  module Emergency
    extend ActiveSupport::Concern
    included do
      acts_as_api
      api_accessible :default do |t|
        t.add :code
        t.add :fire_severity
        t.add :police_severity
        t.add :medical_severity
      end
    end
  end
end
