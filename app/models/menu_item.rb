class MenuItem < ApplicationRecord
  # Associations
  belongs_to :chef_profile

  # Validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :affordable, ->(max_price = 50) { where('price <= ?', max_price) }

  # Instance Methods

  # Formats the price as currency
  def formatted_price
    "$#{'%.2f' % price}"
  end

  # Checks if a menu item is within a specific price range
  def affordable?(max_price)
    price <= max_price
  end
end
