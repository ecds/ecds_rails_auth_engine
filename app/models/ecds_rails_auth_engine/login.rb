# frozen_string_literal: true

#
# The `Login` __model encapsulates login credentials and the associated Bearer
# tokens__. Rails API Auth uses this separate model so that login data and
# user/profile data doesn't get mixed up and the Engine remains clearly
# separeated from the code of the host application. Also, this allows the
# consumming application's user to have multiple logins for different services.
#
# Attributes:
# `who`: Typically an email address, but could be whatever unique identifier
# for the user and the provider.
#
# `provider`: The authentication service used to sign in. If someone uses the
# same email, for example, Google and Facebook, the Login object's provider
# attribute will be updated with the most recent use.
#
# `token`: The JWT for the login.
#
module EcdsRailsAuthEngine
  #
  # Login model
  #
  class Login < ApplicationRecord
    # before_validation :ensure_user

    if EcdsRailsAuthEngine.user_model_relation
      belongs_to EcdsRailsAuthEngine.user_model_relation, foreign_key: :user_id
    end

    private

    def ensure_user
      return true if user_id.present?
      user = User.find_or_create_by(email: self.who)
      self.user_id = user.id
    end

  end
end
