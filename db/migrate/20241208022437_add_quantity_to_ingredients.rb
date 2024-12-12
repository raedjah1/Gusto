class AddQuantityToIngredients < ActiveRecord::Migration[7.2]
  def change
    add_column :ingredients, :quantity, :string
  end
end
