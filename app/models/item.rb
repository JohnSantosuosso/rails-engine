class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, type: :string
  validates_presence_of :description, type: :string
  validates_presence_of :unit_price, type: :float
  validates_numericality_of :unit_price, greater_than_or_equal_to: 0.00
  validates_presence_of :merchant_id, type: :integer

  # def self.find_all(search_params)
  #   if search_params[:name]
  #     Item.where("name ILIKE ?", "%#{search_params[:name]}%")
  #   elsif search_params[:description]
  #     Item.where("description ILIKE ?", "%#{search_params[:description]}%")
  #   elsif search_params[:unit_price]
  #     Item.where("unit_price = ?", "#{search_params[:unit_price]}")
  #   elsif search_params[:merchant_id]
  #     Item.where("merchant_id = ?", "#{search_params[:merchant_id]}")
  #   else
  #     Item.all
  #   end
  # end
end