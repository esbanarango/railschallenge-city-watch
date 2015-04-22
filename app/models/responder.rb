class Responder < ActiveRecord::Base
  self.inheritance_column = nil

  include Responses::Responder

  # Constants
  CAPACITY = [1, 2, 3, 4, 5]

  # Validations
  validates :name, uniqueness: true
  validates :capacity, :name, :type, presence: true
  validates :capacity, inclusion: { in: CAPACITY, message: 'is not included in the list' }
end
