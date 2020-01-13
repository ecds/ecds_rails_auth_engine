require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::TvShows::RickAndMorty.unique.character }
  end
end