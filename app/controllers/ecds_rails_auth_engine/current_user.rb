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
          login = Login.where(oauth2_token: token)
          login.present? ? login.first.user : User.new
        rescue NoMethodError
          User.new
        end
      end
    end
  end
end
