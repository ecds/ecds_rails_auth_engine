# frozen_string_literal: true

require 'ecds_rails_auth_engine/engine'

#
# The engine's main model.
# Configuring the `user_model_relation` was taken directly from
# https://github.com/simplabs/rails_api_auth
#
module EcdsRailsAuthEngine
  # @!attribute [rw] user_model_relation
  # Defines the `Login` model's `belongs_to` relation to the host application's
  # `User` model (or `Account` or whatever the application stores user data
  # in).
  #
  # E.g. is this is set to `:profile`, the `Login` model will have a
  # `belongs_to :profile` relation.
  mattr_accessor :user_model_relation
  mattr_accessor :verification_host
  mattr_accessor :primary_key_type
end
