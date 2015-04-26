class Dispatcher
  attr_accessor :severity, :responders_ready, :emergency, :total_responders_capacity

  def initialize(emergency)
    self.emergency = emergency
  end

  def call
    Responder::TYPES.each do |type|
      type_severity = "#{type}_severity".downcase
      dispatch type if (self.severity = emergency.send(type_severity)) > 0
    end
  end

  private

  def dispatch(type)
    self.responders_ready = Responder.ready.where(type: type).to_a
    perform_optimum if responders_ready.any?
  end

  # Recursive dispatcher algorithm
  def perform_optimum
    return unless finish_perform?

    temp_ready_responders = responders_ready.take_while { |responder| responder.capacity < severity }

    # Check if we have enough capacity to exactly respond
    if enough_capacity_to_respond? temp_ready_responders
      self.responders_ready = temp_ready_responders
    end

    return unless (responder = responders_ready.pop)

    assign_emergency_to responder
    perform_optimum
  end

  # The perfect case where there is a responder with the exact
  # same capacity as the severity
  def same_capacity
    responders_ready.each do |responder|
      if responder.capacity == severity
        assign_emergency_to responder
        break
      end
    end
  end

  def finish_perform?
    !same_capacity.nil? && severity > 0
  end

  def enough_capacity_to_respond?(temp_ready_responders)
    temp_ready_responders.inject(0) { |a, e| a + e.capacity } > severity
  end

  def assign_emergency_to(responder)
    responder.update_attribute('emergency_code', emergency.code)
    self.severity -= responder.capacity
  end
end
