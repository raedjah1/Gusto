class ChefProfile < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :menu_items, dependent: :destroy

  # Validations
  validates :bio, :specialty, :experience, :availability, presence: true

  # Instance methods
  def average_rating
    reviews.average(:rating)
  end

  def total_reviews
    reviews.count
  end

  def upcoming_bookings
    bookings.where('date >= ?', Date.today).order(date: :asc)
  end

  def past_bookings
    bookings.where('date < ?', Date.today).order(date: :desc)
  end

  def available_on?(date)
    # Placeholder for availability logic
    # Consider implementing based on availability format (e.g., array of dates, time slots)
    true
  end

  def top_menu_items
    menu_items.order(created_at: :desc).limit(5)
  end

  def specialties_list
    specialty&.split(',')&.map(&:strip)
  end
end
