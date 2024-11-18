class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Constants
  ROLES = %w[consumer chef admin].freeze

  # Validations
  validates :role, presence: true, inclusion: { in: ROLES }

  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Associations
  has_one :chef_profile
  has_many :bookings # Ensures each user can have multiple bookings

  # Role Methods
  def chef?
    role == 'chef'
  end

  def consumer?
    role == 'consumer'
  end

  def admin?
    role == 'admin'
  end

  # Authentication Token
  def auth_token
    JWT.encode({ user_id: id }, Rails.application.credentials.secret_key_base)
  end
end
