class AddAverageRatingToChefProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :chef_profiles, :average_rating, :float
  end
end
