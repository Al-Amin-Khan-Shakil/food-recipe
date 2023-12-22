require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  before(:each) do
    @user = User.create!(id: 2, name: 'becky', email: 'becky@mail.com', password: 'abcxyz123', confirmed_at: Time.now)
    @food = Food.create(user_id: @user.id, measurement_unit: 'kg', price: 10, quantity: 2, name: 'Chicken')
    sign_in @user
  end
  describe 'GET /foods' do
    it 'returns a successful response' do
      get foods_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get foods_path
      expect(response).to render_template(:index)
    end
    it 'includes correct placeholder text in the response body' do
      get foods_path
      expect(response.body).to include('Food')
    end
  end
  describe 'GET /new' do
    it 'should be response successfull' do
      get newfood_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render the new file' do
      get newfood_path
      expect(response).to render_template(:new)
    end

    it 'should include the placeholder' do
      get newfood_path
      expect(response.body).to include('New Food')
    end
  end
  describe 'POST /create' do
    it 'should create a new food' do
      post foods_path,
           params: { food: { name: 'New food', quantity: 3, price: 1, measurement_unit: 'kg' } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(foods_path)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Measurement unit')
    end

    it 'should render new template on invalid data' do
      post foods_path,
           params: { food: { name: '', quantity: nil, price: nil, measurement_unit: '' } }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end
end
