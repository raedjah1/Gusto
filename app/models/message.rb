class Message < ApplicationRecord
    # Associations
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'
  
    # Validations
    validates :content, presence: true, length: { maximum: 1000 }
    validates :sender_id, presence: true
    validates :receiver_id, presence: true
  
    # Scopes
    scope :recent, -> { order(created_at: :desc) }
    scope :between_users, ->(user1, user2) do
      where(sender_id: [user1.id, user2.id], receiver_id: [user1.id, user2.id])
    end
  
    # Instance Methods
  
    # Formats the message timestamp for display
    def formatted_sent_time
      created_at.strftime('%B %d, %Y at %I:%M %p')
    end
  
    # Checks if the message is sent by a specific user
    def sent_by?(user)
      sender_id == user.id
    end
  end
  