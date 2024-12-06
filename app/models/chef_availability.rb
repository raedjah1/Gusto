class ChefAvailability < ApplicationRecord
  belongs_to :chef_profile

  validates :date, presence: true
end
