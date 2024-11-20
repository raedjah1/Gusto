class AddYearsOfExperienceToChefProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :chef_profiles, :years_of_experience, :integer
  end
end
