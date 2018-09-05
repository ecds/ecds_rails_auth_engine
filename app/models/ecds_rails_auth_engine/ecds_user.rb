module EcdsRailsAuthEngine
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
      after_create :_create_login

      private

      def _create_login
        return if login
        self.login = Login.create!
      end
    end
  end
end
