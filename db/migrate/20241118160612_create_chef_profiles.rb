class CreateChefProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :chef_profiles do |t|
      t.timestamps
    end
  end
end
