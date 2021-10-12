require 'faker'

FactoryBot.define do
  factory :login, class: EcdsRailsAuthEngine::Login do
    who {  }
    user {  }
  end
end
