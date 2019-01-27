class FixedAmount < PriceRule

  # attributes - The Object of price rule configuration
  # {code: , prerequisite:, value: }
  # code - The String code of the item to apply a price rule
  # prerequisite - The String minimum number of items for the price rule to be applicable. The prerequisite must be positive; must be a Number.
  # value - The Float of value of the price rule. The value must be positive; must be a Number;
  def initialize(attributes)
    validates(attributes)

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
    items_applicable_count * (@target.price - @value)
  end

end
