require './application_helper.rb'

items = [
    {code: 'GR1', name: 'Green tea', price: 3.11},
    {code: 'SR1', name: 'Strawberries', price: 5.00},
    {code: 'CF1', name: 'Coffe', price: 11.23},
].map do |item_attributes|
  Item.new(item_attributes)
end

pricing_rules = [
    GetFree.new({target: items[0], prerequisite: 1, value: 1}),
    FixedAmount.new({target: items[1], prerequisite: 3, value: 4.50}),
    Percentage.new({target: items[2], prerequisite: 3, value: 2/3.to_f}),
]

co = Checkout.new(pricing_rules)
co.scan(items[0])
co.scan(items[1])
co.scan(items[2])
pp co.total