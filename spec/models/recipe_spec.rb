require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create!(id: 2, name: 'becky', email: 'becky@mail.com', password: 'abcxyz123', confirmed_at: Time.now)
    @recipe = Recipe.create(user_id: @user.id, name: 'Kabsah', description: 'The best in the west',
                            cooking_time: '1 hour', preparation_time: '1 hour', public: true)
  end

  it 'should not be valid without name' do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end

  it 'should not be valid without preparation_time' do
    @recipe.preparation_time = nil
    expect(@recipe).to_not be_valid
  end

  it 'should not be valid without cooking_time' do
    @recipe.cooking_time = nil
    expect(@recipe).to_not be_valid
  end

  it 'should not be valid without description' do
    @recipe.description = nil
    expect(@recipe).to_not be_valid
  end

  it 'should be a boolean value' do
    expect(@recipe).to be_valid
  end
end
