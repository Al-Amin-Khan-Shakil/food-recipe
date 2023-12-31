class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  has_many :recipes
  has_many :foods
  has_many :recipe_foods, through: :recipes
  def general_shopping_list
    required_food_quantities = calculate_required_food_quantities
    user_food_quantities = calculate_user_food_quantities(required_food_quantities.keys)
    missing_food_quantitie = calculate_missing_food_quantities(required_food_quantities, user_food_quantities)
    puts "missing food quantities #{missing_food_quantitie}"
    {
      missing_food_quantities: missing_food_quantitie,
      total_quantity: missing_food_quantitie.values.sum { |info| info[:missing_quantity] },
      total_cost: missing_food_quantitie.values.sum { |info| info[:total_cost] },
      total_food_items: missing_food_quantitie.keys.size
    }
  end

  private

  def calculate_required_food_quantities
    recipes = Recipe.includes(recipe_foods: :food).where(user: self)
    required_food_quantities = Hash.new(0)
    recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        required_food_quantities[recipe_food.food] += recipe_food.quantity
        puts "food:#{recipe_food.food.name} ,recipe_food quantity:#{recipe_food.quantity}"
      end
    end
    required_food_quantities
  end

  def calculate_user_food_quantities(foods)
    user_food_quantities = Hash.new(0)
    recipe_foods.each do |user_recipe_food|
      if foods.include?(user_recipe_food.food)
        user_food_quantities[user_recipe_food.food] = user_recipe_food.food.quantity
        puts "user_food:#{user_recipe_food.food.name}, quantity:#{user_recipe_food.food.quantity}"
      end
    end
    user_food_quantities
  end

  def calculate_missing_food_quantities(required_food_quantities, user_food_quantities)
    missing_food_quantities = {}
    required_food_quantities.each do |food, required_quantity|
      user_quantity = user_food_quantities[food]
      missing_quantit = [required_quantity - user_quantity, 0].max
      missing_food_quantities[food] = {
        missing_quantity: missing_quantit,
        total_cost: missing_quantit * food.price,
        food_name: food.name
      }
    end
    missing_food_quantities
  end
end
