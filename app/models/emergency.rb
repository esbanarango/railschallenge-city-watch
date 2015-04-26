class Emergency < ActiveRecord::Base
  include Responses::Emergency

  # Validations
  validates :code, uniqueness: true
  validates :code, :fire_severity, :police_severity, :medical_severity, presence: true
  validates :fire_severity, :police_severity, :medical_severity, numericality: { greater_than_or_equal_to: 0 }

  # Scopes
  scope :resolved, lambda { where.not(resolved_at: nil) }
  scope :unresolved, lambda { where(resolved_at: nil) }

  class << self
    def full_responses
      [enough_emergency, count]
    end

    # How many emergencies in the city had enough emergency
    # personnel available to handle them historically.
    def enough_emergency
      total = 0
      current_capacity = Responder.current_capacity
      all.find_each do |emergency|
        Responder::TYPES.each do |type|
          if current_capacity[type].any? { |capacity| capacity >= emergency.send("#{type.downcase}_severity") }
            total += 1
          end
        end
      end
      total
    end
  end
end
