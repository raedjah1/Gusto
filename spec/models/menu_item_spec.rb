require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  # Association tests
  it { should belong_to(:chef_profile) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_length_of(:name).is_at_most(100) }
  it { should validate_length_of(:description).is_at_most(500) }
  it { should validate_numericality_of(:price).is_greater_than(0) }

  # Instance method tests
  describe '#formatted_price' do
    let(:menu_item) { build(:menu_item, price: 29.99) }

    it 'returns price formatted as currency' do
      expect(menu_item.formatted_price).to eq('$29.99')
    end
  end

  describe '#affordable?' do
    let(:menu_item) { build(:menu_item, price: 45.00) }

    it 'returns true when price is less than or equal to max_price' do
      expect(menu_item.affordable?(50)).to be true
    end

    it 'returns false when price is greater than max_price' do
      expect(menu_item.affordable?(40)).to be false
    end
  end
end
