# spec/factories/reviews.rb
FactoryBot.define do
    factory :review do
      user { association :user, role: 'consumer' }
      chef_profile
      rating { rand(1..5) }
      comments { Faker::Lorem.sentence(word_count: 15) }
    end
  end
  