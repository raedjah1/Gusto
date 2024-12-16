class Transaction < ApplicationRecord
  belongs_to :chef_profile

  # Enums
  enum transaction_type: {
    deposit: 'deposit',
    withdrawal: 'withdrawal'
  }

  # Validations
  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: transaction_types.keys }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }

  # Callbacks
  before_validation :ensure_amount_not_zero

  private

  def ensure_amount_not_zero
    errors.add(:amount, "cannot be zero") if amount == 0
  end
end
