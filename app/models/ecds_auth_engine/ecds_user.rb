module EcdsAuthEngine
  #
  # Include this in the consumming application's user model
  # to create relationship with the login model.
  #
  module EcdsUser
    extend ActiveSupport::Concern
    included do
      # attr_accessor :identification
      # attr_accessor :password
      has_one :login
    end
  end
end
