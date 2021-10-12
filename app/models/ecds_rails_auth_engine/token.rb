module EcdsRailsAuthEngine
  class Token < ApplicationRecord
    belongs_to :login, class_name: 'EcdsRailsAuthEngine::Login'
  end
end
