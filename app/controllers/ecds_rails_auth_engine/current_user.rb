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
        # a = request.headers['Authorization']
        token = cookies.signed[:auth]
        return nil if token.nil?
        # begin
        #   token = a.split(' ').last

        #   return nil if token == 'undefined'

          login = EcdsRailsAuthEngine::Login.find_by(token: token)
          return nil if login.nil?
          # return { cookie: token, signed: cookies.signed[:auth]}

          # return nil unless TokenService.verify(login.token)

          User.find(login.user_id)
        # rescue NoMethodError
        #   nil
        # end
      end
    end
  end
end
