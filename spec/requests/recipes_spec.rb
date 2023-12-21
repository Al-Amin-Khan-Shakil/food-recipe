require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
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
                             is_public: true)

    visit new_user_session_path # Assuming this is your sign-in page
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit recipes_path
  end
end
