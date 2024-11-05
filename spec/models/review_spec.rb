require 'rails_helper'

RSpec.describe Review, type: :model do
  it "has a valid factory" do
    expect(create(:review)).to be_valid
  end

  it { should validate_presence_of(:rating) }
  it { should belong_to(:user) }
  it { should belong_to(:chef_profile) }
end
