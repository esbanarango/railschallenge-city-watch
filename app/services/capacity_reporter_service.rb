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

  def responders_by_type
    Responder.where(type: type)
  end

  def total_capacity
    responders_by_type.sum(:capacity)
  end

  def total_available
    responders_by_type.available.sum(:capacity)
  end

  def total_on_duty
    responders_by_type.on_duty.sum(:capacity)
  end

  def total_ready
    responders_by_type.ready.sum(:capacity)
  end
end
