class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  

  validates_presence_of :name

  def self.merchant_name_match_first(name)
    where("name ILIKE ?", "%#{name}%").order(:name).first
  end
end