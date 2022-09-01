class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name, type: :string
  validates_presence_of :description, type: :string
  validates_presence_of :unit_price, type: :float
  validates_numericality_of :unit_price, greater_than_or_equal_to: 0.00
  validates_presence_of :merchant_id, type: :integer

  def self.items_name_match(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def self.items_min_price_match(min_price)
    where("unit_price >= ?", min_price)
  end

  def self.items_max_price_match(max_price)
    where("unit_price <= ?", max_price)
  end

  def self.items_min_max_price_match(min_price, max_price)
    where("unit_price >= ?", min_price).where("unit_price <= ?", max_price)
  end

  def destroy_invoice_items
    invoice_items = InvoiceItem.where(item_id: self.id)
    invoice_items.each do |invoice_item|
      invoice_item.destroy
    end
  end

  def destroy_invoice_if_one_item
    single_item_invoices = invoices.select {|y| y.invoice_items.count == 1}
    single_item_invoices.each do |invoice|
      invoice.delete
    end
  end
end