FactoryBot.define do
  factory :chef_profile do
    # Associate with a user that has role 'chef'
    association :user, factory: :user, role: 'chef'

    specialty { "Italian, French" }  # Ensure this matches the validation format
    bio { Faker::Lorem.paragraph(sentence_count: 3) }

    # Generate array of dates for next 30 days
    availability do
      (0..30).map { |n| (Date.today + n.days).strftime('%Y-%m-%d') }
    end

    experience { "#{Faker::Number.between(from: 1, to: 30)} years of culinary expertise" }

    # Add has_many association for menu_items
    after(:create) do |chef_profile|
      create_list(:menu_item, 3, chef_profile: chef_profile)
    end
  end
end
