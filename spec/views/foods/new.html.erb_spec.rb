require 'rails_helper'

RSpec.describe "foods/new", type: :feature do
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
    visit newfood_path
  end

  scenario 'displays new food form' do
    expect(page).to have_content('New Food')
    expect(page).to have_field('food_name', type: 'text')
    expect(page).to have_field('food_measurement_unit', type: 'text')
    expect(page).to have_field('food_price', type: 'text')
    expect(page).to have_field('food_quantity', type: 'text')
    expect(page).to have_button('Add Food', class: 'submit-button')
  end
  
  scenario 'creates a new food' do
    fill_in 'food_name', with: 'Apple'
    fill_in 'food_measurement_unit', with: 'kg'
    fill_in 'food_price', with: 25
    fill_in 'food_quantity', with: 10
  
    click_button 'Add Food'
  
    expect(page).to have_content('Apple')
    expect(page).to have_content('kg')
    expect(page).to have_content('$25')
    expect(page).to have_content('10')
  end  
end
