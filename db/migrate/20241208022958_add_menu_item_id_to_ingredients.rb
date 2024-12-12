class AddMenuItemIdToIngredients < ActiveRecord::Migration[7.2]
  def change
    add_reference :ingredients, :menu_item, null: false, foreign_key: true
  end
end
