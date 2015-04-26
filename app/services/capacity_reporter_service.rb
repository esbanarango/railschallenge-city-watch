class CapacityReporterService
  attr_accessor :type

  def call
    {
      capacity: {
        'Fire': report('Fire'),
        'Police': report('Police'),
        'Medical': report('Medical')
      }
    }
  end

  def report(type)
    self.type = type
    [
      total_capacity,
      total_available,
      total_on_duty,
      total_ready
    ]
  end

  def responders
    Responder.where(type: type)
  end

  def type_severity
    "#{type.downcase}_severity".to_sym
  end

  def total_capacity
    responders.sum(:capacity)
  end

  def total_available
    responders.available.sum(:capacity)
  end

  def total_on_duty
    responders.on_duty.sum(:capacity)
  end

  def total_ready
    responders.ready.sum(:capacity)
  end
end
