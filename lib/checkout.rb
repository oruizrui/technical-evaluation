class Checkout

  # pricing_rules - The Array of objects (default: [])
  # {code: , prerequisite:, value: }
  # See each price rule to know his values
  def initialize(pricing_rules = [])
    @items = []
    @pricing_rules = pricing_rules
  end

  # item - The Object of item scanned
  # {code: , name:, price: }
  # See each item to know his values
  def scan(item)
    @items << item
  end

  # Returns a subtotal of scanned items, as a Float.
  def subtotal
    @items.map(&:price).sum
  end

  # Returns a sum discounts of scanned items, as a Float.
  # Returns 0.0 If items not have any pricing_rules returs 0, as a Integer.
  def discounts
    return 0.0 unless @pricing_rules.any?
    @pricing_rules.map{ |pricing_rule| pricing_rule.discount(@items) }.reduce(&:+)
  end

  # Returns a calculated total, as a Float.
  def total
    subtotal - discounts
  end

  # Returns a Array of added price rules
  def pricing_rules
    @pricing_rules
  end
  
end
