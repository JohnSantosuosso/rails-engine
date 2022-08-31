require 'rails_helper'

describe "Merchants API" do
  #Happy Path Tests
  it "gets all merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    merchants = response_body[:data]

    expect(response).to be_successful

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    merchant = response_body[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  #Section 2: Searching Merchants By Criteria
  it "finds a merchant by criteria, HAPPY PATH" do
    merchant_1 = Merchant.create!(name: "Shoe Factory")
    merchant_2 = Merchant.create!(name: "Shoe House")
    merchant_3 = Merchant.create!(name: "Air Jordans")

    get "/api/v1/merchants/find?name=Shoe"

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    merchant = response_body[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)
    expect(merchant[:attributes][:name]).to eq("Shoe Factory")
  end
end