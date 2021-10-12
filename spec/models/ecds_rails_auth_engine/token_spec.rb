require 'rails_helper'

module EcdsRailsAuthEngine
  RSpec.describe Token, type: :model do
    it 'belongs to login' do
      user = create(:user)
      login = create(:login, who: user.email, user: user)
      tokens = create_list(:token, 3, login: login, token: TokenService.create(login))
      expect(login.tokens.count).to eq(3)
    end
  end
end
