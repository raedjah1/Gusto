FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(domain: 'example.com') } 
    password { 'password' }
    role { %w[chef consumer].sample }

    # No need to define auth_token since it's not an attribute
    # auth_token will be set using the method defined in the User model after creation
    after(:create) do |user|
      user.auth_token # This will trigger the `auth_token` method
    end
  end
end


