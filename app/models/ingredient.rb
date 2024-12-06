class Ingredient < ApplicationRecord
    # Associations
    belongs_to :menu_item
  
    # Validations
    validates :name, presence: true
    validates :quantity, presence: true
  end