module EcdsRailsAuthEngine
  #
  # Access to user making request
  #
  module CurrentUser
    extend ActiveSupport::Concern
    included do
      #
      # Return the User object for the user making the request
      #
      # @return [User] <description>
      #
      def current_user
        a = request.headers['Authorization']
        begin
          token = a.split(' ').last
          token_contents = TokenService.verify(token)
          p token_contents
          login = Login.find_by(token: token)
          login.user
        rescue NoMethodError
          nil
        end
      end
    end
  end
end
