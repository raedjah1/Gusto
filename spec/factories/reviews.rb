# spec/factories/reviews.rb
FactoryBot.define do
  factory :review do
    association :user, factory: :user, role: 'consumer'
    association :chef_profile
    rating { Faker::Number.between(from: 1, to: 5) }
    comments { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end