require 'spec_helper.rb'

describe PriceRule do

  before(:all) do
    @items = [
        {code: 'GR1', name: 'Green tea', price: 3.11},
        {code: 'SR1', name: 'Strawberries', price: 5.00},
        {code: 'CF1', name: 'Coffe', price: 11.23},
    ].map do |item_attributes|
      Item.new(item_attributes)
    end
  end

  describe 'PriceRule new is successful' do

    it 'GetFree' do
      price_rule = GetFree.new({target: @items[0], prerequisite: 1, value: 1})

      expect(price_rule.target.code).to eq('GR1')
      expect(price_rule.prerequisite).to eq(1)
      expect(price_rule.value).to eq(1)
    end

    it 'FixedAmount' do
      price_rule = FixedAmount.new({target: @items[1], prerequisite: 3, value: 4.50})

      expect(price_rule.target.code).to eq('SR1')
      expect(price_rule.prerequisite).to eq(3)
      expect(price_rule.value).to eq(4.50)
    end

    it 'Percentage' do
      price_rule = Percentage.new({target: @items[2], prerequisite: 3, value: 2/3.to_f})

      expect(price_rule.target.code).to eq('CF1')
      expect(price_rule.prerequisite).to eq(3)
      expect(price_rule.value).to eq(2/3.to_f)
    end

  end

  describe 'PriceRule raise Error excepcion' do

    it 'GetFreeError: value is negative' do
      price_rule = {target: @items[0], prerequisite: 1, value: -2}

      expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
    end

    it 'GetFreeError: value is higher than prerequisite' do
      price_rule = {target: @items[0], prerequisite: 1, value: 2}

      expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
    end

    it 'FixedAmountError: value is negative' do
      price_rule = {target: @items[1], prerequisite: 3, value: -1}

      expect { FixedAmount.new(price_rule) }.to raise_error(PriceRuleError)
    end

    it 'PercentageError: value is negative' do
      price_rule = {target: @items[2], prerequisite: 3, value: -1}

      expect { Percentage.new(price_rule) }.to raise_error(PriceRuleError)
    end

    it 'PercentageError: value is bigger than 1' do
      price_rule = {target: @items[2], prerequisite: 3, value: 2}

      expect { Percentage.new(price_rule) }.to raise_error(PriceRuleError)
    end

  end

end
