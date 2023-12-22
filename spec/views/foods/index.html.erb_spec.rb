require 'rails_helper'

RSpec.describe "foods/index", type: :feature do
  before(:each) do
    @user = User.create!(id: 2,
                         name: 'becky',
                         email: 'becky@mail.com',
                         password: 'abcxyz123',
                         confirmed_at: Time.now)

    @food1 = @user.foods.create!(name: 'Apple', measurement_unit: 'kg', price: 25, quantity: 10)
    @food2 = @user.foods.create!(name: 'Banana', measurement_unit: 'kg', price: 10, quantity: 20)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit foods_path
  end

  scenario 'displays user\'s recipes with remove button' do
    expect(page).to have_content(@food1.name)
    expect(page).to have_content(@food2.name)
    expect(page).to have_content(@food1.price)
    expect(page).to have_content(@food2.price)
    expect(page).to have_content(@food1.quantity)
    expect(page).to have_content(@food2.quantity)
    expect(page).to have_button('Delete', class: 'delete-button')
  end
end
