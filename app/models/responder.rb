class Responder < ActiveRecord::Base
  self.inheritance_column = nil

  include Responses::Responder

  # Constants
  TYPES = %w(Police Fire Medical)

  # Validations
  validates :name, uniqueness: true
  validates :capacity, :name, :type, presence: true
  validates :capacity, inclusion: { in: 1..5, message: 'is not included in the list' }

  # Scopes
  default_scope { order(capacity: :asc) }
  scope :available, -> { where(emergency_code: nil) }
  scope :on_duty, -> { where(on_duty: true) }
  scope :ready, -> { available.on_duty }

  class << self
    def current_capacity
      capacity_hash = {}
      TYPES.each do |type|
        capacity_hash[type] = Responder.where(type: type).pluck(:capacity)
      end
      capacity_hash
    end
  end
end
