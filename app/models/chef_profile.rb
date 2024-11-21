class ChefProfile < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :menu_items, dependent: :destroy

  # Validations
  validates :bio, :specialty, :experience, :availability, presence: true
  #For debug and make functions more compatible with text-generation
  #validates :specialty, format: { with: /\A[a-zA-Z, ]+\z/, message: "can only contain letters and commas" }
  validates :specialty, format: { with: /\A[a-zA-Z, ,&-]+\z/, message: "can only contain letters, commas, &, and -" }
  validate :valid_availability_format


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
    # Check if the provided date is available (assuming it's stored as an array of dates)
    availability.include?(date.to_s) # availability is assumed to be an array of strings
  end

  def top_menu_items
    menu_items.order(created_at: :desc).limit(5)
  end

  def specialties_list
    specialty&.split(',')&.map(&:strip)
  end

  private

  # Custom validation for availability format (ensures dates are valid)
  def valid_availability_format
    if availability.is_a?(Array)
      # Check that each item in the array is a valid date
      invalid_dates = availability.reject { |date| valid_date_format?(date) }
      if invalid_dates.any?
        errors.add(:availability, "contains invalid dates: #{invalid_dates.join(', ')}")
      end
    elsif availability.is_a?(String)
      # If availability is a string, split it and check the dates
      availability.split(',').each do |date|
        if !valid_date_format?(date.strip)
          errors.add(:availability, "must be a valid comma-separated list of dates")
          break
        end
      end
    end
  end

  # Helper method to check date format validity
  def valid_date_format?(date)
    Date.parse(date.strip) rescue false
  end
end
