require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(
      email: 'danie@example.com',
      password: 'supersecurepassword',
      password_confirmation: 'supersecurepassword',
    )
  end
  
  describe 'GET /index' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get users_path, headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'archive user' do
    let(:users) {(create_list(:user, 2)}
    before do 
      auth_token = authenticate_user(user)
      get archive_path(users.first), headers: { 'Authentication' => "Bearer #{auth_token}" }
    end
    
    it 'returns ok response' do
    expect(response).to have_http_status(:ok)
    end 

    it 'does not return the archived user' do
      get users_path, headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(respose).not_to include users.first
    end
  end

  describe 'unarchive user' do
    let(:users) {(create_list(:user, 2)}
    before do 
      auth_token = authenticate_user(user)
      get unarchive_path(users.first), headers: { 'Authentication' => "Bearer #{auth_token}" }
    end
    
    it 'returns ok response' do
    expect(response).to have_http_status(:ok)
    end 

    it 'does returns the unarchived user' do
      get users_path, headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(respose).to include users.first
    end
  end
end
