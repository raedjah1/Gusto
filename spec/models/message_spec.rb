require 'rails_helper'

RSpec.describe Message, type: :model do
  it "has a valid factory" do
    expect(create(:message)).to be_valid
  end

  it { should validate_presence_of(:content) }
  it { should belong_to(:sender).class_name('User') }
  it { should belong_to(:receiver).class_name('User') }
end
