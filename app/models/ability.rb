# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    @user = current_user ||= User.new 
      can :read, :all
      can %i[destroy create public_recipe general_shopping_list], Recipe, user_id: @user.id
      can %i[destroy create], Food, user_id: @user.id
      can %i[create], RecipeFood, recipe_id: @user.id
      can %i[destroy create edit update], RecipeFood do |recipe_food|
        recipe_food.recipe.user_id == @user.id
      end
  end
end
