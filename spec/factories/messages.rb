# spec/factories/messages.rb
FactoryBot.define do
    factory :message do
      sender { association :user }
      receiver { association :user }
      content { Faker::Lorem.sentence(word_count: 10) }
    end
  end
  