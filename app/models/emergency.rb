class Emergency < ActiveRecord::Base
  include Responses::Emergency

  # Validations
  validates :code, uniqueness: true
  validates :code, :fire_severity, :police_severity, :medical_severity, presence: true
  validates :fire_severity, :police_severity, :medical_severity, numericality: { greater_than_or_equal_to: 0 }
end
