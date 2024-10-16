class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :chef_profile
end
