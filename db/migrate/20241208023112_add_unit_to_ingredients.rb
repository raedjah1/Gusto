class AddUnitToIngredients < ActiveRecord::Migration[7.2]
  def change
    add_column :ingredients, :unit, :string
  end
end
