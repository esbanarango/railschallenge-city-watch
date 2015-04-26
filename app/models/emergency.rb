class Emergency < ActiveRecord::Base
  include Responses::Emergency

  # Validations
  validates :code, uniqueness: true
  validates :code, :fire_severity, :police_severity, :medical_severity, presence: true
  validates :fire_severity, :police_severity, :medical_severity, numericality: { greater_than_or_equal_to: 0 }

  # Scopes
  scope :resolved, -> { where.not(resolved_at: nil) }
  scope :unresolved, -> { where(resolved_at: nil) }

  # Relations
  has_many :responders, foreign_key: 'emergency_code', primary_key: :code

  # Callbacks
  after_save :check_resolved, on: :update

  def self.full_responses
    [enough_emergency, count]
  end

  # How many emergencies in the city had enough emergency
  # personnel available to handle them historically.
  def self.enough_emergency
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

  def full_response?
    Responder::TYPES.all? do |type|
      responders.where(type: type).sum(:capacity) >= send("#{type}_severity".downcase)
    end
  end

  private

  def check_resolved
    return unless resolved_at_changed? && !resolved_at.nil?
    responders.update_all(emergency_code: nil)
  end
end
