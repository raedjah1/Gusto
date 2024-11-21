class AddAvailabilityToChefProfiles < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:chef_profiles, :availability)
      add_column :chef_profiles, :availability, :text
    end
  end
end
