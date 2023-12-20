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
end
