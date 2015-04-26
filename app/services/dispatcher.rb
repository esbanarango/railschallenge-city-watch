class Dispatcher
  attr_accessor :current_severity, :responders_ready, :emergency, :total_responders_capacity

  def initialize(emergency)
    self.emergency = emergency
  end

  def call
    Responder::TYPES.each do |type|
      type_severity = "#{type}_severity".downcase
      if (self.current_severity = emergency.send(type_severity)) > 0
        dispatch type
      end
    end
  end

  private

  def dispatch(type)
    self.responders_ready = Responder.ready.where(type: type).to_a
    perform_optimum if responders_ready.any?
  end

  def perform_optimum
    if !responder_same_capacity.nil? && current_severity > 0

      temp_ready_responders = self.responders_ready.take_while { |responder| responder.capacity < current_severity }

      # Check if we have enough capacity to exactly respond
      if temp_ready_responders.inject(0) { |sum, responder| sum + responder.capacity } > current_severity
        self.responders_ready = temp_ready_responders
      end

      if responder = self.responders_ready.pop
        set_emergancy_code responder
        self.current_severity -= responder.capacity
        perform_optimum
      end

    end
  end

  # The perfect case where there is a responder with the exact
  # same capacity as the severity
  def responder_same_capacity
    responders_ready.each do |responder|
      if responder.capacity == current_severity
        set_emergancy_code responder
        break
      end
    end
  end

  def set_emergancy_code(responder)
    responder.update_attribute('emergency_code',emergency.code)
  end

end