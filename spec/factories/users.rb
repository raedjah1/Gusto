# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.unique.email }
      password { "password" }
      role { %w[chef consumer].sample }
    end
  end
  