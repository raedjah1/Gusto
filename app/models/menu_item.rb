class MenuItem < ApplicationRecord
  # Associations
  belongs_to :chef_profile
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  has_one_attached :image

  # Validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  # Image validations
  validate :acceptable_image

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

  # Returns a placeholder if no image is uploaded
  def display_image
    if image.attached?
      image.variant(resize_to_limit: [300, 300]) # Resize image for consistent display
    else
      'default_image.png' # Path to a default placeholder image
    end
  end

  private

  def acceptable_image
    return unless image.attached?

    unless image.blob.byte_size <= 5.megabytes
      errors.add(:image, 'is too large (maximum is 5MB)')
    end

    acceptable_types = ['image/jpeg', 'image/jpg', 'image/png']
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, 'must be a JPEG or PNG')
    end
  end
end
