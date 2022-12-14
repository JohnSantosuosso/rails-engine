class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  validates_presence_of :name

  def self.merchant_name_match_first(name)
    where("name ILIKE ?", "%#{name}%").order(:name).first
  end
end