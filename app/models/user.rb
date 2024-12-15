class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         

  has_one_attached :profile_picture
  # Constants
  ROLES = %w[consumer chef admin].freeze

  # Validations
  validates :role, presence: true, inclusion: { in: ROLES }

  # Associations
  has_one :chef_profile
  has_many :bookings # Ensures each user can have multiple bookings
  has_many :favorites
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

  # Authentication Token (JWT)
  def auth_token
    JWT.encode({ user_id: id }, Rails.application.credentials.jwt_secret_key)
  end

  # Set default role to 'consumer' if not provided
  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= 'consumer' # Default to 'consumer' if no role is provided
  end
end
