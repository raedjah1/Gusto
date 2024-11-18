# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:role) }
  
  # Change has_many to has_one because a user has one chef_profile
  it { should have_one(:chef_profile) }
end
