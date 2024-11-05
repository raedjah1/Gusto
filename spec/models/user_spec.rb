require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:role) }
  it { should have_many(:chef_profiles) }
end
