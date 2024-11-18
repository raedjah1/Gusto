# spec/factories/bookings.rb
FactoryBot.define do
  factory :booking do
    # Ensure `user` is properly associated, with a role of 'consumer'
    user { association :user, role: 'consumer' }
    
    # Ensure `chef_profile` is associated
    chef_profile

    # Add date as required, using Faker to generate a future date
    date { Faker::Date.forward(days: 30) }

    # Add time as required (using a default time if needed)
    time { Faker::Time.forward(days: 30, period: :morning) }  # You can change the period to :afternoon, :evening, etc.

    # Add guests as required (a valid number for the guests field)
    guests { 2 }  # Example: Setting a default value for guests

    # Sample status values for `status` attribute
    status { %w[pending confirmed completed cancelled].sample }
  end
end
