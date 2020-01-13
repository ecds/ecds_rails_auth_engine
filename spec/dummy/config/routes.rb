Rails.application.routes.draw do
  mount EcdsRailsAuthEngine::Engine => "/ecds_rails_auth_engine"
  get '/users', to: 'users#index'

end
