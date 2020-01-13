# frozen_string_literal: true

EcdsRailsAuthEngine::Engine.routes.draw do
  get '/auth/verify', to: 'tokens#verify'
  get '/tokens', to: 'tokens#show'
  delete '/tokens', to: 'tokens#destroy'
end
