class ChefProfile < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :menu_items, dependent: :destroy
  has_many :chef_availabilities, dependent: :destroy

  # Validations
  validates :bio, :specialty, :experience, presence: true
  validates :specialty, format: { with: /\A[a-zA-Z, ]+\z/, message: 'can only contain letters and commas' }
  # No need to validate availability anymore
  validate :valid_availability_dates

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
    # Check if the provided date exists in the chef_availabilities table
    chef_availabilities.exists?(date: date)
  end

  def top_menu_items
    menu_items.order(created_at: :desc).limit(5)
  end

  def specialties_list
    specialty&.split(',')&.map(&:strip)
  end

  private

  # Custom validation for availability format (ensures dates are valid)
  def valid_availability_dates
    # Since we're using a separate table for availability, this can be simplified
    chef_availabilities.each do |availability|
      if !valid_date_format?(availability.date.to_s)
        errors.add(:chef_availabilities, "contains an invalid date: #{availability.date}")
      end
    end
  end

  # Helper method to check date format validity
  def valid_date_format?(date)
    Date.parse(date) rescue false
  end
end
