require 'rails_helper'

RSpec.describe 'recipes/index', type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    @recipe1 = Recipe.create(user_id: @user.id,
                             name: 'Kabsah',
                             description: 'The best in the west',
                             cooking_time: 45,
                             preparation_time: 40,
                             public: true)

    @recipe2 = Recipe.create(user_id: 3,
                             name: 'Rice',
                             description: 'The best in the west',
                             cooking_time: 45,
                             preparation_time: 20,
                             public: true)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipes_path
  end

  scenario 'displays user\'s recipes with remove button' do
    expect(page).to have_content(@recipe1.name)
    expect(page).to have_content(@recipe1.description)
    expect(page).to have_button('Remove', class: 'remove-button')
  end
end
