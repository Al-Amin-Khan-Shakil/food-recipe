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
                             cooking_time: '1 hour',
                             preparation_time: '1 hour',
                             public: true)
    sign_in @user
    get '/recipes'
  end

  describe 'GET /index' do
    it 'should be response successull' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render the posts index file' do
      expect(response).to render_template(:index)
    end

    it 'should include the placeholder' do
      expect(response.body).to include('Kabsah')
    end
  end

  describe 'GET /show' do
    it 'should be response successull' do
      get recipe_path(@recipe1)
      expect(response).to have_http_status(:ok)
    end

    it 'should render the show template' do
      get recipe_path(@recipe1)
      expect(response).to render_template(:show)
    end

    it 'should include the recipe name' do
      get recipe_path(@recipe1)
      expect(response.body).to include('Kabsah')
    end
  end

  describe 'PATCH /toggle_public' do
    it 'should toggle the public status' do
      patch toggle_public_recipe_path(@recipe1)
      @recipe1.reload
      expect(@recipe1.public).to eq(false)
    end

    it 'should redirect to the recipe show page' do
      patch toggle_public_recipe_path(@recipe1)
      expect(response).to redirect_to(recipe_path(@recipe1))
    end

    it 'should display a notice' do
      patch toggle_public_recipe_path(@recipe1)
      expect(flash[:notice]).to eq('Recipe public status toggled.')
    end
  end

  describe 'GET /public_recipes' do
    it 'should be response successfull' do
      get public_recipes_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render the public_recipe file' do
      get public_recipes_path
      expect(response).to render_template(:public_recipe)
    end

    it 'should include the placeholder' do
      get public_recipes_path
      expect(response.body).to include('Public Recipes')
    end
  end

  describe 'GET /new' do
    it 'should be response successfull' do
      get new_recipe_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render the new file' do
      get new_recipe_path
      expect(response).to render_template(:new)
    end

    it 'should include the placeholder' do
      get new_recipe_path
      expect(response.body).to include('New Recipe')
    end  
  end

  describe 'POST /create' do
    it 'should create a new recipe' do
      post recipes_path, params: { recipe: { name: 'New Recipe', preparation_time: '30 mins', cooking_time: '1 hour', description: 'Delicious dish', public: true } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(assigns(:recipe))
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Recipe was successfully created.')
    end

    it 'should render new template on invalid data' do
      post recipes_path, params: { recipe: { name: '', preparation_time: '', cooking_time: '', description: '', public: true } }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end
end
