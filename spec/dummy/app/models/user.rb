class User < ApplicationRecord
  has_many :logins, class_name: 'EcdsRailsAuthEngine::Login'
end
