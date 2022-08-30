require 'rails_helper'

describe "Merchant Items API" do
  it "gets all of a merchant's items" do
    id = create(:merchant).id
    id_2 = create(:merchant).id
    create_list(:item, 3, merchant_id: id)
    create_list(:item, 3, merchant_id: id_2)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_items.count).to eq(3)

    merchant_items.each do |item|
    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(Integer)

    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)

    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)

    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)
    end
  end

end