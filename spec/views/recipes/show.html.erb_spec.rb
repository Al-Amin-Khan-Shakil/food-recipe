require 'rails_helper'

RSpec.describe 'recipes/show', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    @recipe = Recipe.create(user_id: @user.id,
                            name: 'Kabsah',
                            description: 'The best in the west',
                            cooking_time: 45,
                            preparation_time: 40,
                            public: true)
    @food = Food.create(name: 'Ingredient 1', measurement_unit: 'kg', price: 10, quantity: 1, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 2, recipe_id: @recipe.id, food_id: @food.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipe_path(@recipe)
  end

  scenario 'displays recipe details and ingredients' do
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content('Preparation Time:')
    expect(page).to have_content('Cooking Time:')
    expect(page).to have_content('Description:')
    expect(page).to have_content('Public:')
    expect(page).to have_link('Generate Shopping List', href: general_shopping_list_path)
    expect(page).to have_link('Add Ingredient', href: new_recipe_recipe_food_path(@recipe))
    @recipe.recipe_foods.each do |recipe_food|
      expect(page).to have_content(recipe_food.food.name)
      expect(page).to have_content(recipe_food.quantity)
      expect(page).to have_content("$#{recipe_food.quantity * recipe_food.food.price}")

      expect(page).to have_link('Modify', href: edit_recipe_recipe_food_path(@recipe, recipe_food))
      expect(page).to have_button('Delete', class: 'ingre-delete-button')
    end
  end
end
