require 'ecds_rails_auth_engine'

EcdsRailsAuthEngine.tap do |a|
  a.user_model_relation = :user
  a.verification_host = 'fauxoauth.org'
end
