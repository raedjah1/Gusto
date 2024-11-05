require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it "has a valid factory" do
    expect(create(:menu_item)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should belong_to(:chef_profile) }
end
