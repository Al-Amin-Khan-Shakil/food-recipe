require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create(name: 'user1') }
  let(:recipe) do
    Recipe.create(name: 'chicken tikka', preparation_time: '1hour', cooking_time: '1hour', description: 'text',
                  public: true, user_id: 1)
  end

  describe 'GET /index' do
    it 'should be response successull' do
      get '/recipes'
      expect(response).to have_http_status(:ok)
    end

    it 'should render the posts index file' do
      get '/recipes'
      expect(response).to render_template(:index)
    end

    it 'should include the placeholder' do
      get '/recipes'
      expect(response.body).to include('chidken tikka')
    end
  end
end
