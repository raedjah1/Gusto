require 'rails_helper'

RSpec.describe ChefProfile, type: :model do
  it "has a valid factory" do
    expect(create(:chef_profile)).to be_valid
  end
  let(:user) { create(:user) }
  let(:auth_headers) { { Authorization: "Bearer #{user.auth_token}" } }

  it { should validate_presence_of(:bio) }
  it { should validate_presence_of(:specialty) }
  it { should belong_to(:user) }
  it { should have_many(:menu_items) }
  it { should have_many(:bookings) }
end
