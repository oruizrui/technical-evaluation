class Item

  attr_reader :code, :name, :price

  # item - The Object of item initialized
  # {code: , name:, price: }
  # code - The String code the item
  # name - The String naming the item
  # price - The Number pricing the item. Must be a Number, Must be higher or equal than 0.
  # Returns code, name, price of the item.
  def initialize(attributes)
    validates(attributes)

    @code = attributes[:code]
    @name = attributes[:name]
    @price = attributes[:price]
  end

  # Returns an exception for
  # Unknown code || name || price
  # Price is not a number
  # Price is lower than 0
  def validates(attributes)
    raise ItemError.new('Unknown code') unless attributes[:code]
    raise ItemError.new('Unknown name') unless attributes[:name]
    raise ItemError.new('Unknown price') unless attributes[:price]
    raise ItemError.new('Price must be a number') unless attributes[:price].is_a? Numeric
    raise ItemError.new('Price cant be lower than 0') unless attributes[:price] >= 0
  end

end

class ItemError < StandardError
  # ItemError - The Object of ItemError initialized
  # Returns a message of error
  def initialize(error)
    message = 'ItemError: ' + error
    super
  end
end

