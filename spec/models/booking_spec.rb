require 'rails_helper'

RSpec.describe Booking, type: :model do
  it "has a valid factory" do
    expect(create(:booking)).to be_valid
  end

  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:user) }
  it { should belong_to(:chef_profile) }
end
