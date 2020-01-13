require 'faker'

FactoryBot.define do
  factory :login, class: EcdsRailsAuthEngine::Login do
    who { Faker::Internet.email }
    user { create(:user) }
  end
end