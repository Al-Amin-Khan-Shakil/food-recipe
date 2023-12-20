class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true, length: { maximum: 255 }
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
  validates :public, inclusion: { in: [true, false] }
  attr_accessor :total_cost, :food_count

  def self.public_recipe
    Recipe.where(public: true).order(created_at: :desc)
  end

  def calculate_total_cost_and_food_count
    total_cost = 0
    food_count = 0

    recipe_foods.each do |food_recipe|
      total_cost += food_recipe.quantity * food_recipe.food.price
      food_count += 1
    end

    { total_cost:, food_count: }
  end
end
