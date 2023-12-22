require 'rails_helper'

RSpec.describe 'recipe_foods/edit', type: :feature do
  before(:each) do
    @user = User.create!(id: 1,
                         name: 'Alice',
                         email: 'alice@example.com',
                         password: 'password123',
                         confirmed_at: Time.now)

    @recipe = Recipe.create!(user_id: @user.id,
                             name: 'Pasta',
                             description: 'Delicious pasta',
                             cooking_time: 30,
                             preparation_time: 15,
                             public: true)

    @food = Food.create!(name: 'Banana', measurement_unit: 'kg', price: 10, quantity: 20, user_id: @user.id)

    @recipe_food = @recipe.recipe_foods.create!(quantity: 2, food_id: @food.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  scenario 'displays edit recipe food form' do
    visit edit_recipe_recipe_food_path(@recipe, @recipe_food)

    expect(page).to have_content('Edit Recipe Food')
    expect(page).to have_field('recipe_food_quantity', type: 'number', with: @recipe_food.quantity)
    expect(page).to have_select('recipe_food_food_id', selected: @food.name)
    expect(page).to have_button('Update Recipe Food', class: 'edit-recipe-food-form-submit')
  end

  scenario 'updates the recipe food' do
    new_quantity = 3
    @user.foods.create!(name: 'Apple', measurement_unit: 'kg', price: 25, quantity: 10)

    visit edit_recipe_recipe_food_path(@recipe, @recipe_food)

    fill_in 'recipe_food_quantity', with: new_quantity
    find('#recipe_food_food_id option', text: 'Apple').select_option

    click_button 'Update Recipe Food'

    expect(page).to have_content('Recipe Food was successfully updated.')
    expect(page).to have_content(new_quantity)
    expect(page).to have_content('Apple')
  end
end
