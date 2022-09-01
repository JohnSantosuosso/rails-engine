class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :merchants, through: :items

end