FactoryBot.define do
  factory :transaction do
    amount { "9.99" }
    transaction_type { "MyString" }
    chef_profile { nil }
  end
end
