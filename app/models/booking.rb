class Booking < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :chef_profile

  # Validations
  validates :date, presence: true
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

  # Marks the booking as completed
  def mark_as_completed
    update(status: 'completed') if date < Date.today && status == 'confirmed'
  end

  # Marks the booking as cancelled
  def cancel
    update(status: 'cancelled') if status == 'pending'
  end
end
