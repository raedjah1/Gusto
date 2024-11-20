class AddCuisineTypesToChefProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :chef_profiles, :cuisine_types, :text
  end
end
