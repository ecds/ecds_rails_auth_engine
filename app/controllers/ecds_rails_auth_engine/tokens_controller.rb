# frozen_string_literal: true

# This is required
# require_dependency 'ecds_rails_auth_engine/application_controller'

#
# <Description>
#
module EcdsRailsAuthEngine
  #
  # <Description>
  #
  class TokensController < ActionController::API
  include ActionController::Cookies

    before_action :set_token, only: %i[show destroy]

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def show
      if @login
        @login.token = TokenService.create(@login)
        Rails.logger.debug "NEW TOKEN!!! #{@login.token}"
        @login.save
        response.headers['Cache-Control'] = 'no-store'
        response.headers['Pragma'] = 'no-cache'
        # @login.expires_in = 3600
        # render json: @login, include: ['user']
        render json: { token: SecureRandom.hex(10) }, status: :ok
      else
        render json: {
          status: 401,
          message: 'The current login is invalid. Please try logging in again.'
        }
      end
    end

    def verify
      token_contents = TokenService.verify_remote(request.headers['Authorization'].split(' ').last)
      login = Login.find_or_create_by(who: token_contents[:who])

      # TODO: How does RailsApiAuth do this?
      user = User.find_or_create_by(email: token_contents[:who])
      user.display_name = token_contents[:name]
      user.save
      login.user_id = user.id

      login.provider = token_contents[:provider]
      access_token = TokenService.create(login)
      Token.create!(token: access_token, login: login)
      login.save
      cookies.signed[:auth] = {
        value: access_token,
        httponly: true,
        expires: 2.weeks.from_now,
        same_site: :none,
        secure: 'Secure'
      }
      render json: { access_token: cookies.signed[:auth] }, status: :ok
    end

    def destroy
      cookies.signed[:auth] = {
        value: @token,
        httponly: true,
        expires: 2.seconds.from_now,
        same_site: :none,
        secure: 'Secure'
      }
      @token.delete
      head 200
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.find_by(token: cookies.signed[:auth])
      @login = @token.login
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.fetch(:access_token, {})
    end
  end
end
