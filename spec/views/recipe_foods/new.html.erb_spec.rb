require 'rails_helper'

RSpec.describe "recipe_foods/new", type: :feature do
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
    
    Food.create!(name: 'Banana', measurement_unit: 'kg', price: 10, quantity: 20, user_id: @user.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  scenario 'displays new recipe food form' do
    visit new_recipe_recipe_food_path(@recipe)

    expect(page).to have_content('New Recipe Food')
    expect(page).to have_field('recipe_food_quantity', type: 'number')
    expect(page).to have_select('recipe_food_food_id', options: ['Select Food', 'Banana'])
    expect(page).to have_button('Create Recipe Food', class: 'recipe-food-form-submit')
  end

  scenario 'creates a new recipe food' do
    food = @user.foods.create!(name: 'Apple', measurement_unit: 'kg', price: 25, quantity: 10)

    visit new_recipe_recipe_food_path(@recipe)

    fill_in 'recipe_food_quantity', with: 2
    find("#recipe_food_food_id option", text: "Apple").select_option

    click_button 'Create Recipe Food'

    save_and_open_page

    expect(page).to have_content('Recipe Food was successfully created.')
    expect(page).to have_content('2')
    expect(page).to have_content('Apple')
  end
end
