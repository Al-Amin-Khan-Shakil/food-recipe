require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  before(:each) do
    @user = User.create!(id: 2, name: 'becky', email: 'becky@mail.com', password: 'abcxyz123', confirmed_at: Time.now)
    @recipe = Recipe.create(user_id: @user.id, name: 'Kabsah', description: 'The best in the west',
                            cooking_time: '1 hour', preparation_time: '1 hour', public: true)
    @food = Food.create(user_id: @user.id, measurement_unit: 'kg', price: 10, quantity: 2, name: 'Chicken')
    sign_in @user
  end

  describe 'GET /recipes/:recipe_id/recipe_foods/new' do
    it 'should be response successfull' do
      get new_recipe_recipe_food_path(@recipe)
      expect(response).to have_http_status(:ok)
    end

    it 'should render the new template' do
      get new_recipe_recipe_food_path(@recipe)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /recipes/:recipe_id/recipe_foods' do
    it 'should create a new recipe food' do
      post recipe_recipe_foods_path(@recipe), params: { recipe_food: { quantity: 2, food_id: @food.id } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(recipe_path(@recipe))
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Recipe Food was successfully created.')
    end

    it 'should render new template on invalid data' do
      post recipe_recipe_foods_path(@recipe), params: { recipe_food: { quantity: nil, food_id: nil } }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /recipes/:recipe_id/recipe_foods/:id/edit' do
    it 'should be response successfull' do
      recipe_food = RecipeFood.create(quantity: 2, food_id: @food.id, recipe_id: @recipe.id)
      get edit_recipe_recipe_food_path(@recipe, recipe_food)
      expect(response).to have_http_status(:ok)
    end

    it 'should render the edit template' do
      recipe_food = RecipeFood.create(quantity: 2, food_id: @food.id, recipe_id: @recipe.id)
      get edit_recipe_recipe_food_path(@recipe, recipe_food)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /recipes/:recipe_id/recipe_foods/:id' do
    it 'should update a recipe food' do
      recipe_food = RecipeFood.create(quantity: 2, food_id: @food.id, recipe_id: @recipe.id)
      patch recipe_recipe_food_path(@recipe, recipe_food), params: { recipe_food: { quantity: 3 } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(recipe_path(@recipe))
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Recipe Food was successfully updated.')
    end

    it 'should render edit template on invalid data' do
      recipe_food = RecipeFood.create(quantity: 2, food_id: @food.id, recipe_id: @recipe.id)
      patch recipe_recipe_food_path(@recipe, recipe_food), params: { recipe_food: { quantity: nil } }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE /recipes/:recipe_id/recipe_foods/:id' do
    it 'should delete a recipe food' do
      recipe_food = RecipeFood.create(quantity: 2, food_id: @food.id, recipe_id: @recipe.id)
      delete recipe_recipe_food_path(@recipe, recipe_food)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(recipe_path(@recipe))
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Recipe Food was successfully deleted.')
    end
  end
end
