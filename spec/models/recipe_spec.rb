require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'user 1') }
  let(:recipe) do
    user.recipes.new(name: 'recipe 1', preparation_time: '1 hour', cooking_time: '1 hour', description: 'description 1',
                     public: true)
  end

  before { recipe.save }

  it 'should not be valid without name' do
    recipe.name = nil
    expect(recipe).to_not be_valid
  end

  it 'should not be valid without preparation_time' do
    recipe.preparation_time = nil
    expect(recipe).to_not be_valid
  end

  it 'should not be valid without cooking_time' do
    recipe.cooking_time = nil
    expect(recipe).to_not be_valid
  end

  it 'should not be valid without description' do
    recipe.description = nil
    expect(recipe).to_not be_valid
  end

  it 'should be a boolean value' do
    expect(recipe).to be_valid
  end
end
