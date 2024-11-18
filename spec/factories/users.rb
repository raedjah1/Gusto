# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password" }
    role { %w[chef consumer].sample }
    auth_token { SecureRandom.hex(10) } # Add this line to simulate an auth token
  end
end
