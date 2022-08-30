require 'rails_helper'

describe "Merchant Items API" do
  it "gets all of a merchant's items" do
    id = create(:merchant).id
    id_2 = create(:merchant).id
    create_list(:item, 3, merchant_id: id)
    create_list(:item, 3, merchant_id: id_2)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful

  end

end