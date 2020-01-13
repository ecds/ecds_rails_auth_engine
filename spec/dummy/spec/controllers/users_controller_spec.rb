require 'rails_helper'
require 'token_service'

RSpec.describe 'UsersController', type: :request do
  describe 'GET verify' do
    
    # context 'with authenticated user' do      
    #   let(:name) { Faker::Movies::Lebowski.character }
    #   before {
    #     EcdsRailsAuthEngine::Login.create!(token: '12345')
    #     User.first.update_attribute(:name, name)
    #     get '/users', headers: { Authorization: "Bearer #{User.first.logins.first.token}" }
    #   }
  
    #   it 'responds with the authenticated user' do
    #     expect(JSON.parse(response.body)['name']).to eq(name)
    #   end
    # end

    context 'with no authenticated user' do
      before {
        get '/users'
      }

      it 'responds with 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
