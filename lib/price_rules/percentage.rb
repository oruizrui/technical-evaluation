class Percentage < PriceRule

  # pricing_rules  - The Object of price rule configuration
  # {code: , prerequisite:, value: }
  # code - The String code of the item to apply a price rule
  # prerequisite - The String minimum number of items for the price rule to be applicable.
  # value - The Float of value of the price rule. The value must be posirtive and bettwen 0 - 1.
  # Returns an exception if value is negative.
  # Returns an exception if value is bigger than 1.
  def initialize(attributes)

    raise PriceRuleError.new('Value not be higher than 1') if attributes[:value] > 1
    raise PriceRuleError.new('Value not be lowest than 0') if attributes[:value] < 0

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

end
