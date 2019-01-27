class Item
  attr_reader :code, :name, :price

  # item  - The Object of item initialized
  # {code: , name:, price: }
  # code - The String code the item
  # name - The String naming the item
  # price - The Float Number pricing the item
  # Returns code, name, price of the item.
  def initialize(attributes)
    @code = attributes[:code]
    @name = attributes[:name]
    @price = attributes[:price]
  end

end
