require 'rails_helper'

describe "Item Merchant API" do
  #Happy Path Tests
  it "gets an item's merchant" do
    id = create(:merchant).id
    create_list(:item, 3, merchant_id: id)

    get "/api/v1/items/#{Item.first.id}/merchant"

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    merchant = response_body[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
end