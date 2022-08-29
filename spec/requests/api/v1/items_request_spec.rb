require 'rails_helper'

describe "Items API" do
  it "gets all items" do
    id = create(:merchant).id
    id_2 = create(:merchant).id
    create_list(:item, 3, merchant_id: id)
    create_list(:item, 3, merchant_id: id_2)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(6)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_a(Integer)
    end
  end

  it "gets one item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body, symbolize_names: true)

    expect(found_item).to have_key(:id)
    expect(found_item[:id]).to be_an(Integer)

    expect(found_item).to have_key(:name)
    expect(found_item[:name]).to be_a(String)

    expect(found_item).to have_key(:description)
    expect(found_item[:description]).to be_a(String)

    expect(found_item).to have_key(:unit_price)
    expect(found_item[:unit_price]).to be_a(Float)

    expect(found_item).to have_key(:merchant_id)
    expect(found_item[:merchant_id]).to be_a(Integer)

  end
end