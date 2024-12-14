class AddAvailabilityToChefProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :chef_profiles, :availability, :string
  end
end
