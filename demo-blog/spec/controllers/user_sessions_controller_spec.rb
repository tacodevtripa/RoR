require 'rails_helper'

RSpec.describe User::SessionsController, type: :controller do
  fixtures :users
  let(:user) { users(:one) }

  before do
    # Set the devise mapping for the user model
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create (JSON format)' do
    context 'with valid credentials' do
      it 'returns a JWT token and HTTP 200 status' do
        post :create, params: { user: { email: user.email, password: 'password123' } }, format: :json

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['token']).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized status and error message' do
        post :create, params: { user: { email: user.email, password: 'wrongpassword' } }, format: :json

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Invalid email or password')
      end
    end

    context 'when user does not exist' do
      it 'returns an unauthorized status and error message' do
        post :create, params: { user: { email: 'nonexistent@example.com', password: 'password123' } }, format: :json

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Invalid email or password')
      end
    end
  end
end
