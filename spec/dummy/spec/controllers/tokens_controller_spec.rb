require 'rails_helper'
require 'token_service'

RSpec.describe EcdsRailsAuthEngine::TokensController, type: :controller do
  routes { EcdsRailsAuthEngine::Engine.routes }
  # ts = TokenService new
  describe 'GET verify' do
    let(:email) { Faker::Internet.email }

    before do
      stub_request(:post, 'https://auth.digitalscholarship.emory.edu/tokens?access_token=12345')
        .with(headers: { Accept: '*/*', 'User-Agent': 'Ruby' })
        .to_return(
          status: 200,
          body: "{who: #{email}, provider: 'Google'}",
          headers: {}
        )
    end
    # before {
    #   get '/auth/verify.json'
    # }
    it 'responds with a token a signed token' do
      request.headers['Authorization'] = 'Bearer 12345'
      get :verify, format: 'json'
      expect(JSON.parse(response.body)['access_token']).to eq(EcdsRailsAuthEngine::Login.first.tokens.first.token)
    end

    it 'generates a token based on account data' do
      request.headers['Authorization'] = 'Bearer 12345'
      get :verify, format: 'json'
      contents = TokenService.verify(EcdsRailsAuthEngine::Login.first.tokens.first.token).first
      expect(contents['data']['who']).to eq(EcdsRailsAuthEngine::Login.first.who)
    end

    it 'deletes token but not the login' do
      user = create(:user)
      login = create(:login, who: user.email, user: user)
      token = create(:token, login: login, token: TokenService.create(login))
      expect(login.tokens.count).to eq(1)
      cookies.signed[:auth] = {
        value: token.token,
        httponly: true,
        same_site: :none,
        secure: 'Secure'
      }
      post :destroy
      expect(login.tokens).to be_empty
    end

  end
end
