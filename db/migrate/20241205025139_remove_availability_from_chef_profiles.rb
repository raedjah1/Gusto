class RemoveAvailabilityFromChefProfiles < ActiveRecord::Migration[7.2]
  def change
    remove_column :chef_profiles, :availability, :string
  end
end
