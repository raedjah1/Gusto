# spec/factories/bookings.rb
FactoryBot.define do
    factory :booking do
      user { association :user, role: 'consumer' }
      chef_profile
      date { Faker::Date.forward(days: 30) }
      status { %w[pending confirmed completed cancelled].sample }
    end
  end
  