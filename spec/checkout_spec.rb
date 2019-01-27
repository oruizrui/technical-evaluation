require 'spec_helper.rb'

describe Checkout do
  before(:all) do
    @items = [
        {code: 'GR1', name: 'Green tea', price: 3.11},
        {code: 'SR1', name: 'Strawberries', price: 5.00},
        {code: 'CF1', name: 'Coffe', price: 11.23},
    ].map do |item_attributes|
      Item.new(item_attributes)
    end

    @pricing_rules = [
        GetFree.new({target: @items[0], prerequisite: 1, value: 1}),
        FixedAmount.new({target: @items[1], prerequisite: 3, value: 4.50}),
        Percentage.new({target: @items[2], prerequisite: 3, value: 2/3.to_f}),
    ]
  end

  describe 'Checkout new is successful' do

    it 'With prire rules' do
      co = Checkout.new(@pricing_rules)

      expect(co.pricing_rules.any?).to be true
    end

    it 'Without price rules' do
      co = Checkout.new()

      expect(co.pricing_rules.any?).to be false
    end

    it 'New checkout return total and discounts 0.0' do
      co = Checkout.new(@pricing_rules)

      expect(co.total).to eql(0.0)
      expect(co.discounts).to eql(0.0)
    end

  end

  describe 'Proposed examples' do

    it 'Basket 1' do
      co = Checkout.new(@pricing_rules)
      co.scan(@items[0])
      co.scan(@items[1])
      co.scan(@items[0])
      co.scan(@items[0])
      co.scan(@items[2])

      expect(co.total).to be(22.45)
    end

    it 'Basket 2' do
      co = Checkout.new(@pricing_rules)
      co.scan(@items[0])
      co.scan(@items[0])

      expect(co.total).to be(3.11)
    end

    it 'Basket 3' do
      co = Checkout.new(@pricing_rules)
      co.scan(@items[1])
      co.scan(@items[1])
      co.scan(@items[0])
      co.scan(@items[1])

      expect(co.total).to be(16.61)
    end

    it 'Basket 4' do
      co = Checkout.new(@pricing_rules)
      co.scan(@items[0])
      co.scan(@items[2])
      co.scan(@items[1])
      co.scan(@items[2])
      co.scan(@items[2])

      expect(co.total).to be(30.57)
    end

  end

end


