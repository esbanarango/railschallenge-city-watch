# require "test_helper"

# class DispatcherTest < ActiveSupport::TestCase

#   def setup
#     super
#     # Responder.create({ type: 'Police', name: 'P-101', capacity: 1 })
#     # Responder.create({ type: 'Police', name: 'P-102', capacity: 2, on_duty: true })
#     # Responder.create({ type: 'Police', name: 'P-103', capacity: 3, on_duty: true })
#     # Responder.create({ type: 'Police', name: 'P-104', capacity: 4, on_duty: true })
#     # Responder.create({ type: 'Police', name: 'P-105', capacity: 5, on_duty: true })

#     Responder.create({ type: 'Police', name: 'P-101', capacity: 1, on_duty: true })
#     Responder.create({ type: 'Police', name: 'P-102', capacity: 2, on_duty: true })
#     Responder.create({ type: 'Police', name: 'P-103', capacity: 3, on_duty: true })
#     Responder.create({ type: 'Police', name: 'P-104', capacity: 4, on_duty: true })
#     Responder.create({ type: 'Police', name: 'P-105', capacity: 5, on_duty: true })
#     Responder.create({ type: 'Police', name: 'P-111', capacity: 11, on_duty: true })


#   end

#   def emergency
#     @emergency = Emergency.create({ code: 'E-00000001', fire_severity: 3, police_severity: 12, medical_severity: 1 })
#   end

#   def dispatcher
#     @dispatcher ||= Dispatcher.new emergency
#   end


#   # test 'test this' do
#   #   # setup
#   #   puts Responder.all.inspect
#   #   puts dispatcher.call.inspect
#   #   Responder.destroy_all
#   # end

# end
