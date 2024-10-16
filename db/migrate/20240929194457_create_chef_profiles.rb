class CreateChefProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :chef_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :bio
      t.string :specialty
      t.integer :experience
      t.string :availability

      t.timestamps
    end
  end
end
