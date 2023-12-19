require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'user 1') }
  let(:recipe) do
    user.recipes.create(name: 'recipe 1', preparation_time: '1 hour', cooking_time: '1 hour',
                        description: 'description 1', public: true)
  end
  let(:food) { user.foods.create(name: 'food 1', measurement_unit: 'kg', price: 100, quantity: 1) }
  let(:recipe_food) { RecipeFood.create(quantity: 1, recipe_id: recipe.id, food_id: food.id) }

  it 'should be valid' do
    expect(recipe_food).to be_valid
  end

  it 'should be valid' do
    recipe_food.quantity = '1'
    expect(recipe_food).to be_valid
  end
end
