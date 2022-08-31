class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def self.merchant_name_match_first(name)
    where("name ILIKE ?", "%#{name}%").order(:name).first
  end
end