# spec/factories/menu_items.rb
FactoryBot.define do
    factory :menu_item do
      chef_profile
      name { Faker::Food.dish }
      description { Faker::Food.description }
      price { Faker::Commerce.price(range: 10.0..50.0) }
    end
  end
