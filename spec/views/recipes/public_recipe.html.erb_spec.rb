require 'rails_helper'

RSpec.feature 'Recipes index page', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    @public_recipe = Recipe.create(user_id: @user.id,
                                   name: 'Public Recipe',
                                   description: 'A public recipe',
                                   cooking_time: 30,
                                   preparation_time: 20,
                                   public: true)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipes_path
  end

  scenario 'displays public recipes with remove button' do
    expect(page).to have_content('Public Recipes')
    expect(page).to have_content(@public_recipe.name)
    expect(page).to have_button('Remove', class: 'remove-button')
  end
end
