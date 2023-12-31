class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :recipe_id, uniqueness: { scope: :food_id, message: 'Food already exists modify to increase the quantity' }
end
