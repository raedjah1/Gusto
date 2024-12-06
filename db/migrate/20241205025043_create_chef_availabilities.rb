class CreateChefAvailabilities < ActiveRecord::Migration[7.2]
  def change
    create_table :chef_availabilities do |t|
      t.references :chef_profile, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
