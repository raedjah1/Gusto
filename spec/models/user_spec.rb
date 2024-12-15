require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should have_one(:chef_profile) }
end
