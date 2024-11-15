class Booking < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :chef_profile

  # Validations
  validates :date, :time, :guests, presence: true
  validates :guests, numericality: { only_integer: true, greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending confirmed completed cancelled] }

  # Scopes for filtering bookings based on status
  scope :pending, -> { where(status: 'pending') }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :completed, -> { where(status: 'completed') }
  scope :cancelled, -> { where(status: 'cancelled') }

  # Instance Methods

  # Checks if the booking date is in the future
  def upcoming?
    date >= Date.today
  end

  # Checks if the booking date is in the past
  def past?
    date < Date.today
  end

  # Marks the booking as completed if the date has passed and it was confirmed
  def mark_as_completed
    update(status: 'completed') if past? && status == 'confirmed'
  end

  # Cancels a pending booking
  def cancel
    update(status: 'cancelled') if status == 'pending'
  end

  # Formats the date and time for display
  def formatted_date_time
    "#{date.strftime('%B %d, %Y')} at #{time.strftime('%I:%M %p')}"
  end
end
