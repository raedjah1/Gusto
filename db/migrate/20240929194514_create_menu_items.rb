class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.references :chef_profile, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
