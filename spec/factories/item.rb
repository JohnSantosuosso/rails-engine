FactoryBot.define do
  factory :item do
    association :merchant, factory: :merchant
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price }
  end
end