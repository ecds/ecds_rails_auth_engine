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
    before_action :set_token, only: %i[show update destroy]

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def show
      if @login
        @login.access_token = TokenService.create(@login)
        @login.save
        response.headers['Cache-Control'] = 'no-store'
        response.headers['Pragma'] = 'no-cache'
        @login.expires_in = 3600
        render json: @login, include: ['user']
      else
        render json: {
          status: 401,
          message: 'The current login is invalid. Please try logging in again.'
        }
      end
    end

    def verify
      # p params
      token_contents = TokenService.verify_remote(params[:access_token])
      login = Login.find_or_create_by(who: token_contents[:who])
      # TODO: How does RailsApiAuth do this?
      if login.user.nil?
        login.user = User.create
      end
      login.provider = token_contents[:provider]
      access_token = TokenService.create(login)
      login.token = access_token
      login.save
      render json: { access_token: access_token }
    end

    def destroy
      HTTParty.post(
        "https://#{EcdsRailsAuthEngine.verification_host}/tokens/revoke"
      )
      @login.access_token = nil
      @login.save
      head 200
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @login = Login.find_by(access_token: params[:auth_code])
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.fetch(:access_token, {})
    end
  end
end
