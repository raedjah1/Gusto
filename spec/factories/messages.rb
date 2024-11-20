# spec/factories/messages.rb
FactoryBot.define do
  factory :message do
    association :sender, factory: :user
    association :receiver, factory: :user
    content { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
