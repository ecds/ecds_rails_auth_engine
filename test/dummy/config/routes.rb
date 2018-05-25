Rails.application.routes.draw do
  mount EcdsAuthEngine::Engine => "/ecds_auth_engine"
end
