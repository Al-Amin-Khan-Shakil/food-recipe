require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create(name: 'user1') }
  let(:recipe) { user.recipes.create() }

  describe 'GET /index' do
    it 'should be response successull' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:ok)
    end

    it 'should render the posts index file' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'should include the placeholder' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Pagination')
    end
  end
end
