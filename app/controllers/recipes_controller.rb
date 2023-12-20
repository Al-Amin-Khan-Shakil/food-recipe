class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = current_user.recipes.includes(recipe_foods: :food).find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.recipe_foods.destroy_all
    @recipe.destroy!
    redirect_to recipes_path, notice: 'Recipe successfully deleted.'
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe, notice: 'Recipe public status toggled.'
  end

  def public_recipe
    @public_recipes = Recipe.public_recipe.includes(:recipe_foods, :user)
    @public_recipes.each do |recipe|
      calculation_result = recipe.calculate_total_cost_and_food_count
      recipe.total_cost = calculation_result[:total_cost]
      recipe.food_count = calculation_result[:food_count]
    end
  end

  def general_shopping_list
    @user = current_user
    @shopping_list = @user.general_shopping_list
  end
end
