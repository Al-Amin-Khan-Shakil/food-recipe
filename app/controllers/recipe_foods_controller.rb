class RecipeFoodsController < ApplicationController
  load_and_authorize_resource
  before_action :find_recipe

  def new
    @recipe_food = @recipe.recipe_foods.build
  end

  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'Recipe Food was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def update
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe Food was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @recipe_food.destroy

    redirect_to recipe_path(@recipe), notice: 'Recipe Food was successfully deleted.'
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
