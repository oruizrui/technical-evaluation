class Item
  attr_reader :code, :name, :price

  # item  - The Object of item initialized
  # {code: , name:, price: }
  # code - The String code the item
  # name - The String naming the item
  # price - The Float Number pricing the item
  # Returns code, name, price of the item.
  # Returns an exception unless code || name || price.
  def initialize(attributes)

    raise ItemError.new('code') unless attributes[:code]
    raise ItemError.new('name') unless attributes[:name]
    raise ItemError.new('price') unless attributes[:price]

    @code = attributes[:code]
    @name = attributes[:name]
    @price = attributes[:price]
  end

end

class ItemError < StandardError
  def initialize(field)
    message = 'Incomplete item fields. Please check: ' + field
    super
  end
end

