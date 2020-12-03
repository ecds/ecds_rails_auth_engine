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
      login.user_id = User.find_or_create_by(email: token_contents[:who]).id

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
      render json: { access_token: SecureRandom.hex(10) }, status: :ok
    end

    def destroy
      @login.token = nil
      @login.save
      head 200
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_token
      cookies.each do |cookie|
        puts cookie
      end
      @login = Login.find_by(token: cookies.signed[:auth])
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.fetch(:access_token, {})
    end
  end
end
