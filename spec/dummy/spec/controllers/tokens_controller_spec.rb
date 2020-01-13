require 'rails_helper'
require 'token_service'

RSpec.describe EcdsRailsAuthEngine::TokensController, type: :controller do
  routes { EcdsRailsAuthEngine::Engine.routes }
  # ts = TokenService new
  describe 'GET verify' do
    before {
      stub_request(:post, "https://#{EcdsRailsAuthEngine.verification_host}/tokens?access_token=12345").
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(
          status: 200,
          body: "{who: #{Faker::Internet.email}, provider: 'Google'}",
          headers: {}
        )
      }
    # before {
    #   get '/auth/verify.json'
    # }
    it 'responds with a token a signed token' do
      get :verify, format: 'json', params: { access_token: '12345' }
      expect(JSON.parse(response.body)['access_token']).to eq(EcdsRailsAuthEngine::Login.first.token)
    end

    it 'generates a token based on account data' do
      get :verify, format: 'json', params: { access_token: '12345' }
      contents = TokenService.verify(EcdsRailsAuthEngine::Login.first.token).first
      expect(contents['data']['who']).to eq(EcdsRailsAuthEngine::Login.first.who)
    end
  end
end
