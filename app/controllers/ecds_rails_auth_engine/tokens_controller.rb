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
        Rails.logger.debug "LOGIN!!! #{@login.token}"
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
      Rails.logger.debug "VERIFIED RESPONSE: #{token_contents}"
      login = Login.find_or_create_by(who: token_contents[:who])

      # TODO: How does RailsApiAuth do this?
      user = User.find_or_create_by(email: token_contents[:who])
      10.times { Rails.logger.debug "CONTENTS: #{token_contents}"}
      user.display_name = token_contents[:name]
      user.save
      login.user_id = user.id

      login.provider = token_contents[:provider]
      access_token = TokenService.create(login)
      login.token = access_token
      Rails.logger.debug "CREATED TOKEN #{access_token}"
      login.save
      cookies.signed[:auth] = {
        value: access_token,
        httponly: true,
        expires: 2.weeks.from_now,
        same_site: :none,
        secure: 'Secure'
      }
      Rails.logger.debug "CREATED FROM: #{access_token}"
      Rails.logger.debug "AUTH COOKIE: #{cookies.signed[:auth]}"
      Rails.logger.debug "TOKEN IN DB: #{login.token}"
      render json: { access_token: cookies.signed[:auth] }, status: :ok
    end

    def destroy
      # # Rails.logger.debug "AUTH COOKIE BEFORE: #{cookies.signed[:auth]}"
      # # Rails.logger.debug "AUTH COOKIE BEFORE: #{cookies.signed[:auth]}"
      cookies.signed[:auth] = {
        value: @login.token,
        httponly: true,
        expires: 2.seconds.from_now,
        same_site: :none,
        secure: 'Secure'
      }
      # cookies.delete :auth
      # Rails.logger.debug "AUTH COOKIE AFTER: #{cookies.signed[:auth]}"
      @login.token = nil
      @login.save
      head 200
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @login = Login.find_by(token: cookies.signed[:auth])
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.fetch(:access_token, {})
    end
  end
end
