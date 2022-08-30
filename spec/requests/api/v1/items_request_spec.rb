require 'rails_helper'

describe "Items API" do
  #Happy Path Tests
  it "gets all items" do
    id = create(:merchant).id
    id_2 = create(:merchant).id
    create_list(:item, 3, merchant_id: id)
    create_list(:item, 3, merchant_id: id_2)

    get '/api/v1/items'

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    items = response_body[:data]

    expect(response).to be_successful

    expect(items.count).to eq(6)
    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it "gets one item, happy path" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    item = response_body[:data]

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it "creates an item, happy path" do
    merchant = create(:merchant)
    item_params = ({
                    name: "Lorem ipsum",
                    description: "Ipsum agas tialsme",
                    unit_price: 45.4,
                    merchant_id: merchant.id

    })
    headers = {"CONTENT_TYPE" => "application/json"}
    
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    
    created_item = Item.last

    response_body = JSON.parse(response.body, symbolize_names: true)

    item = response_body[:data]
    expect(created_item.name).to eq(item_params[:name])
  end

  it "can update an existing item, happy path" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    id = item.id
    previous_name = Item.last.name
    item_params = { name: "Ipsum Lorem Fom" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Ipsum Lorem Fom")
  end

  it "can delete an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    delete "/api/v1/items/#{item.id}"

    expect(response.status).to eq(204)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  #Sad Path Tests
  it "gets one item, sad path" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    delete "/api/v1/items/#{item.id}"
    get "/api/v1/items/#{item.id}"

    expect(response.status).to eq(404)
  end

  it "create a new item with missing parameters" do
    merchant = create(:merchant)
    item_params = {
      name: 'Lorem ipsum forem',
      description: "Whacme alsid",
      merchant_id: merchant.id
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response.status).to eq(404)

  end
end