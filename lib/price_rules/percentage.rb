class Percentage < PriceRule

  # attributes - The Object of price rule configuration
  # {code: , prerequisite:, value: }
  # code - The String code of the item to apply a price rule
  # prerequisite - The String minimum number of items for the price rule to be applicable. The prerequisite must be positive; must be a Number.
  # value - The Float of value of the price rule. The value must be positive; must be a Number; between(0,1).
  def initialize(attributes)
    validates(attributes)
    self_validates(attributes)

    @target = attributes[:target]
    @prerequisite = attributes[:prerequisite]
    @value = attributes[:value]
  end

  # items - The Array of items scanned
  # Returns Float Number of discount calculated when price rule is applyed to items
  # Returns 0 if the number of items is less than the prerequisite
  def discount(items)
    items_applicable_count = items.select{|item| item.code == @target.code }.count
    return 0.0 if items_applicable_count < @prerequisite
    items_applicable_count * (@target.price * (1 - @value))
  end

  # attributes - The Object of price rule configuration
  # {code: , prerequisite:, value: }
  # Returns an exception for
  # Value > 1
  # Value < 0
  def self_validates(attributes)
    raise PriceRuleError.new('Value cannot be higher than 1') if attributes[:value] > 1
    raise PriceRuleError.new('Value cannot be lower than 0') if attributes[:value] < 0
  end

end
