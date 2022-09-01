require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:merchant)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0.00) }
  end

  describe 'class methods' do
    it 'items_name_match' do
      merchant = Merchant.create!(name: "Shoe Factory")
      item_1 = Item.create!(name: "Air Jordans", merchant_id: merchant.id, description: "Item 1 description", unit_price: 10.00)
      item_2 = Item.create!(name: "Kanye Boots", merchant_id: merchant.id, description: "Item 2 description", unit_price: 200.00)
      item_3 = Item.create!(name: "Stilettos", merchant_id: merchant.id, description: "Item 3 description", unit_price: 300.00)
      item_4 = Item.create!(name: "Air Johns", merchant_id: merchant.id, description: "Item 4 description", unit_price: 400.00)
      item_5 = Item.create!(name: "Fair Jordans", merchant_id: merchant.id, description: "Item 5 description", unit_price: 500.00)

      expect(Item.items_name_match("Air")).to eq([item_1, item_4, item_5])
    end

    it 'items_min_price_match' do
      merchant = Merchant.create!(name: "Shoe Factory")
      item_1 = Item.create!(name: "Air Jordans", merchant_id: merchant.id, description: "Item 1 description", unit_price: 10.00)
      item_2 = Item.create!(name: "Kanye Boots", merchant_id: merchant.id, description: "Item 2 description", unit_price: 200.00)
      item_3 = Item.create!(name: "Stilettos", merchant_id: merchant.id, description: "Item 3 description", unit_price: 300.00)
      item_4 = Item.create!(name: "Air Johns", merchant_id: merchant.id, description: "Item 4 description", unit_price: 400.00)
      item_5 = Item.create!(name: "Fair Jordans", merchant_id: merchant.id, description: "Item 5 description", unit_price: 500.00)

      expect(Item.items_min_price_match(100.00)).to eq([item_2, item_3, item_4, item_5])
    end

    it 'items_max_price_match' do
      merchant = Merchant.create!(name: "Shoe Factory")
      item_1 = Item.create!(name: "Air Jordans", merchant_id: merchant.id, description: "Item 1 description", unit_price: 10.00)
      item_2 = Item.create!(name: "Kanye Boots", merchant_id: merchant.id, description: "Item 2 description", unit_price: 200.00)
      item_3 = Item.create!(name: "Stilettos", merchant_id: merchant.id, description: "Item 3 description", unit_price: 300.00)
      item_4 = Item.create!(name: "Air Johns", merchant_id: merchant.id, description: "Item 4 description", unit_price: 400.00)
      item_5 = Item.create!(name: "Fair Jordans", merchant_id: merchant.id, description: "Item 5 description", unit_price: 500.00)

      expect(Item.items_max_price_match(300.00)).to eq([item_1, item_2, item_3])
    end

    it 'items_min_max_price_match' do
      merchant = Merchant.create!(name: "Shoe Factory")
      item_1 = Item.create!(name: "Air Jordans", merchant_id: merchant.id, description: "Item 1 description", unit_price: 10.00)
      item_2 = Item.create!(name: "Kanye Boots", merchant_id: merchant.id, description: "Item 2 description", unit_price: 200.00)
      item_3 = Item.create!(name: "Stilettos", merchant_id: merchant.id, description: "Item 3 description", unit_price: 300.00)
      item_4 = Item.create!(name: "Air Johns", merchant_id: merchant.id, description: "Item 4 description", unit_price: 400.00)
      item_5 = Item.create!(name: "Fair Jordans", merchant_id: merchant.id, description: "Item 5 description", unit_price: 500.00)

      expect(Item.items_min_max_price_match(100.00, 300.00)).to eq([item_2, item_3])
    end

    it 'destroy_invoice_if_one_item' do
      customer_1 = Customer.create!(first_name: "John", last_name: "Doe")
      merchant_1 = Merchant.create!(name: "Shoe Factory")
      item_1 = Item.create!(name: "Air Jordans", merchant_id: merchant_1.id, description: "Item 1 description", unit_price: 10.00)
      item_2 = Item.create!(name: "Kanye Boots", merchant_id: merchant_1.id, description: "Item 2 description", unit_price: 200.00)
      invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id, status: "shipped")
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 10.00)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 10.00)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id, status: "shipped")
      invoice_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 10.00)


      item_1.destroy_invoice_if_one_item
      
      expect(Invoice.all.count).to eq(1)

    end
  end
end
