require 'spec_helper.rb'

describe Item do

  it 'Item new is successful' do
    item_attributes =  {code: 'GR1', name: 'Green tea', price: 3.11}
    item = Item.new(item_attributes)

    expect(item.code).to eq('GR1')
    expect(item.name).to eq('Green tea')
    expect(item.price).to eq(3.11)
  end

  describe 'Item raise Error excepcion' do

    it 'Unknown code' do
      item_attributes =  {code: nil, name: 'Green tea', price: 3.11}

      expect { Item.new(item_attributes) }.to raise_error(ItemError)
    end

    it 'Unknown name' do
      item_attributes =  {code: 'GR1', name: nil, price: 3.11}

      expect { Item.new(item_attributes) }.to raise_error(ItemError)
    end

    it 'Unknown price' do
      item_attributes =  {code: 'GR1', name: 'Green tea', price: nil}

      expect { Item.new(item_attributes) }.to raise_error(ItemError)
    end

    it 'Price must be a number' do
      item_attributes =  {code: 'GR1', name: 'Green tea', price: '3.11'}

      expect { Item.new(item_attributes) }.to raise_error(ItemError)
    end

    it 'Price is lower than 0' do
      item_attributes =  {code: 'GR1', name: 'Green tea', price: -1}

      expect { Item.new(item_attributes) }.to raise_error(ItemError)
    end

  end

end

