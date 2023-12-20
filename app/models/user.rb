class User < ApplicationRecord
  validates :name, presence: true
  has_many :recipes
  has_many :foods
  has_many :recipe_foods, through: :recipes

  def general_shopping_list
    recipes = Recipe.where(user: self)
    required_food_quantities = Hash.new(0)

    # Calculate the total required quantity of each food in all recipes
    recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        required_food_quantities[recipe_food.food] += recipe_food.quantity
      end
    end

    # Calculate the total quantity of each food the user has
    user_food_quantities = Hash.new(0)
    recipe_foods.each do |user_recipe_food|
      user_food_quantities[user_recipe_food.food] += user_recipe_food.food.quantity
    end

    # Calculate the missing quantities and total cost
    missing_food_quantities = {}
    total_cost = 0

    required_food_quantities.each do |food, required_quantity|
      user_quantity = user_food_quantities[food]
      puts('user quantity:', required_quantity)
      missing_quantity = [required_quantity - user_quantity, 0].max
      missing_food_quantities[food] = {
        missing_quantity:,
        total_cost: missing_quantity * food.price,
        food_name: food.name
      }
      total_cost += missing_food_quantities[food][:total_cost]
    end

    {
      missing_food_quantities:,
      total_quantity: missing_food_quantities.values.sum { |info| info[:missing_quantity] },
      total_cost:,
      total_food_items: missing_food_quantities.keys.size
    }
  end
end
