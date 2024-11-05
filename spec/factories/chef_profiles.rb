# spec/factories/chef_profiles.rb
FactoryBot.define do
    factory :chef_profile do
      user { association :user, role: 'chef' }
      bio { Faker::Food.description }
      specialty { Faker::Food.ethnic_category }
      experience { "#{rand(1..10)} years" }
      availability { "Mon-Fri, 10am - 6pm" }
    end
  end
  