require 'spec_helper.rb'

describe Item do

  it 'Item new is successful' do
    item_attributes =  {code: 'GR1', name: 'Green tea', price: 3.11}
    item = Item.new(item_attributes)

    expect(item.code).to eq('GR1')
    expect(item.name).to eq('Green tea')
    expect(item.price).to eq(3.11)
  end

end

