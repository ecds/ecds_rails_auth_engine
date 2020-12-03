require 'rails_helper'
require 'token_service'

RSpec.describe EcdsRailsAuthEngine::TokensController, type: :controller do
  routes { EcdsRailsAuthEngine::Engine.routes }
  # ts = TokenService new
  describe 'GET verify' do
    before do
      stub_request(:post, 'https://auth.digitalscholarship.emory.edu/tokens?access_token=12345')
        .with(headers: { Accept: '*/*', 'User-Agent': 'Ruby' })
        .to_return(
          status: 200,
          body: "{who: #{Faker::Internet.email}, provider: 'Google'}",
          headers: {}
        )
    end
    # before {
    #   get '/auth/verify.json'
    # }
    it 'responds with a token a signed token' do
      request.headers['Authorization'] = 'Bearer 12345'
      get :verify, format: 'json'
      expect(JSON.parse(response.body)['access_token']).to eq(EcdsRailsAuthEngine::Login.first.token)
    end

    it 'generates a token based on account data' do
      request.headers['Authorization'] = 'Bearer 12345'
      get :verify, format: 'json'
      contents = TokenService.verify(EcdsRailsAuthEngine::Login.first.token).first
      expect(contents['data']['who']).to eq(EcdsRailsAuthEngine::Login.first.who)
    end

    it 'returs 401 when '
  end
end
