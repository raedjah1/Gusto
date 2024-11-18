# db/seeds.rb

# Clear existing users
User.destroy_all

# Create users
chefs = FactoryBot.create_list(:user, 10, role: 'chef')
consumers = FactoryBot.create_list(:user, 20, role: 'consumer')

# Create chef profiles
chefs.each do |chef|
  FactoryBot.create(:chef_profile, user: chef)
end

# Create menu items for each chef
ChefProfile.all.each do |profile|
  FactoryBot.create_list(:menu_item, rand(3..5), chef_profile: profile)
end

# Create bookings
consumers.each do |consumer|
  chef_profile = ChefProfile.all.sample
  FactoryBot.create(:booking, user: consumer, chef_profile: chef_profile)
end

# Create reviews
ChefProfile.all.each do |profile|
  consumers.sample(5).each do |consumer|
    FactoryBot.create(:review, user: consumer, chef_profile: profile)
  end
end

# Create messages between chefs and consumers
10.times do
  sender = User.where(role: 'consumer').sample
  receiver = User.where(role: 'chef').sample
  FactoryBot.create(:message, sender: sender, receiver: receiver)
end
