require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many(:items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it 'merchant_name_match_first' do
      merchant_1 = Merchant.create!(name: "Shoe Factory")
      merchant_2 = Merchant.create!(name: "Shoe House")
      merchant_3 = Merchant.create!(name: "Air Jordans")

      expect(Merchant.merchant_name_match_first("Shoe")).to eq(merchant_1)
    end
  end

end
