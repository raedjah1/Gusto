class Review < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :chef_profile

  # Validations
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comments, length: { maximum: 1000 }, allow_blank: true
  validates :user_id, presence: true
  validates :chef_profile_id, presence: true

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :top_reviews, -> { where('rating >= ?', 4).order(rating: :desc) }

  # Instance Methods

  # Formats the review's creation date for display
  def formatted_date
    created_at.strftime('%B %d, %Y')
  end

  # Checks if the review was left by a particular user
  def authored_by?(user)
    user_id == user.id
  end
end
