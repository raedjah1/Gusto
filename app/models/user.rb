class User < ApplicationRecord
  # Devise modules...
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Role Constants
  ROLES = %w[consumer chef admin].freeze

  def chef?
    role == "chef"
  end

  def consumer?
    role == "consumer"
  end

  def admin?
    role == "admin"
  end
end
