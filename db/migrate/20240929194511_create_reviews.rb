class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chef_profile, null: false, foreign_key: true
      t.integer :rating
      t.text :comments

      t.timestamps
    end
  end
end
