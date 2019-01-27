class PriceRule

  def target
    @target
  end

  def prerequisite
    @prerequisite
  end

  def value
    @value
  end

end

class PriceRuleError < StandardError
  def initialize(message)
    super
  end
end
