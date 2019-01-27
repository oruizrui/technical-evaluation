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

    describe 'Common exceptions on PriceRule' do

      it 'Unknown target' do
        price_rule = {target: nil, prerequisite: 1, value: 2}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

      it 'Unknown prerequisite' do
        price_rule = {target: @items[0], prerequisite: nil, value: 2}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

      it 'Unknown value' do
        price_rule = {target: @items[0], prerequisite: 1, value: nil}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

      it 'Prerequisite must be a number' do
        price_rule = {target: @items[0], prerequisite: '1', value: 2}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

      it 'Prerequisite must be a positive number' do
        price_rule = {target: @items[0], prerequisite: -1, value: 2}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

      it 'Value must be a number' do
        price_rule = {target: @items[0], prerequisite: 1, value: '2'}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

      it 'Value must be a positive number' do
        price_rule = {target: @items[0], prerequisite: 1, value: -2}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

    end

    describe 'Exceptions for GetFree' do

      it 'Value cannot be higher than prerequisite' do
        price_rule = {target: @items[0], prerequisite: 1, value: 2}

        expect { GetFree.new(price_rule) }.to raise_error(PriceRuleError)
      end

    end

    describe 'Exceptions for Percentage' do

      it 'Value cannot be higher than 1' do
        price_rule = {target: @items[2], prerequisite: 3, value: 2.to_f}

        expect { Percentage.new(price_rule) }.to raise_error(PriceRuleError)
      end

      it 'Value cannot be lower than 0' do
        price_rule = {target: @items[2], prerequisite: 3, value: -10.to_f}

        expect { Percentage.new(price_rule) }.to raise_error(PriceRuleError)
      end

    end

  end

end
