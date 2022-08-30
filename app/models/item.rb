class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, type: :string
  validates_presence_of :description, type: :string
  validates_presence_of :unit_price, type: :float
  validates_numericality_of :unit_price, greater_than_or_equal_to: 0.00
  validates_presence_of :merchant_id, type: :integer
end