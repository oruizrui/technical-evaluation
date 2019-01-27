class PriceRule

  # Returns a target of PriceRule
  def target
    @target
  end

  # Returns a prerequisite of PriceRule
  def prerequisite
    @prerequisite
  end

  # Returns a value of PriceRule
  def value
    @value
  end

  # Returns an exception for
  # Unknown target || prerequisite || value
  # Prerequisite is not a number
  # Value is not a number
  # Prerequisite is lower than 0
  # Value is lower than 0
  def validates(attributes)
    raise PriceRuleError.new('Unknown target') unless attributes[:target]
    raise PriceRuleError.new('Unknown prerequisite') unless attributes[:prerequisite]
    raise PriceRuleError.new('Unknown value') unless attributes[:value]
    raise PriceRuleError.new('Prerequisite must be a Number') unless attributes[:prerequisite].is_a? Numeric
    raise PriceRuleError.new('Prerequisite cannot be lower than 0') if attributes[:prerequisite] < 0
    raise PriceRuleError.new('Value must be a Number') unless attributes[:value].is_a? Numeric
    raise PriceRuleError.new('Value cannot be lower than 0') if attributes[:value] < 0
  end

end

class PriceRuleError < StandardError
  # PriceRuleError - The Object of PriceRuleError initialized
  # Returns a message of error
  def initialize(error)
    message = 'PriceRuleError: ' + error
    super
  end
end
