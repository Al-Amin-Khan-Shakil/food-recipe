require 'rails_helper'

RSpec.describe "recipes/new", type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit new_recipe_path
  end

  scenario 'displays new recipe form and creates a new recipe' do
    expect(page).to have_content('New Recipe')

    fill_in 'recipe_name', with: 'Spaghetti Bolognese'
    fill_in 'recipe_preparation_time', with: 30
    fill_in 'recipe_cooking_time', with: 60
    fill_in 'recipe_description', with: 'A classic Italian dish'
    check 'recipe_public'

    click_button 'Create Recipe'

    expect(page).to have_content('Recipe was successfully created.')
    expect(page).to have_content('Spaghetti Bolognese')
    expect(page).to have_content('A classic Italian dish')
  end
end
