require 'faker'

FactoryBot.define do
  factory :user, class: "User" do
    name { Faker::TvShows::RickAndMorty.unique.character }
    display_name { Faker::Music::Hiphop.artist }
    email { Faker::Internet.email }
  end
end
