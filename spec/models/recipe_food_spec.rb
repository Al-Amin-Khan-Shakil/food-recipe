require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.create!(id: 2, name: 'becky', email: 'becky@mail.com', password: 'abcxyz123', confirmed_at: Time.now)
    @recipe = Recipe.create(user_id: @user.id, name: 'Kabsah', description: 'The best in the west',
                            cooking_time: '1 hour', preparation_time: '1 hour', public: true)
    @food = Food.create(user_id: @user.id, measurement_unit: 'kg', price: 10, quantity: 2, name: 'Chicken')
    @recipe_food = RecipeFood.create(quantity: 1, recipe_id: @recipe.id, food_id: @food.id)
  end

  it 'should be valid' do
    p @recipe_food
    expect(@recipe_food).to be_valid
  end

  it 'should not be valid' do
    @recipe_food.quantity = 'one'
    expect(@recipe_food).to_not be_valid
  end
end
