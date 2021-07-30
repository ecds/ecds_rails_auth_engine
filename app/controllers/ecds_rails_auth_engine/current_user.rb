module EcdsRailsAuthEngine
  #
  # Access to user making request
  #
  module CurrentUser
    extend ActiveSupport::Concern
    include ActionController::Cookies

    included do
      #
      # Return the User object for the user making the request
      #
      # @return [User] <description>
      #
      def current_user
        token = if Rails.env == 'test'
          cookies[:auth]
        else
          cookies.signed[:auth]
        end

        return User.new if token.nil?

        login = EcdsRailsAuthEngine::Login.find_by(token: token)

        return User.new if login.nil?

        User.find(login.user_id)
      end
    end
  end
end
