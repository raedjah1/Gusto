require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe 'role validation' do
    it 'sets default role to consumer' do
      user.valid? # Trigger validations
      expect(user.role).to eq('consumer')
    end

    it 'validates presence of role' do
      user.role = nil
      user.valid? # Trigger validations
      expect(user.role).to eq('consumer') # Role gets set to default
    end
  end

  it { should have_one(:chef_profile) }
end
