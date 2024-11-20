FactoryBot.define do
  factory :booking do
    # Associate a user with the role of 'consumer'
    association :user, factory: :user, role: 'consumer'

    # Associate with a chef_profile
    association :chef_profile

    # Generate future date and time
    date { Faker::Date.forward(days: 30) }
    time { Faker::Time.forward(days: 30, period: %i[morning afternoon evening].sample) }

    # Default guests (must be greater than 0)
    guests { Faker::Number.between(from: 1, to: 10) }

    # Status must be one of: pending, confirmed, completed, cancelled
    status { %w[pending confirmed completed cancelled].sample }

    # Add trait for completed bookings in the past
    trait :completed do
      status { 'completed' }
      date { Faker::Date.backward(days: 30) }
    end

    # Add trait for upcoming confirmed bookings
    trait :upcoming_confirmed do
      status { 'confirmed' }
      date { Faker::Date.forward(days: 30) }
    end
  end
end
