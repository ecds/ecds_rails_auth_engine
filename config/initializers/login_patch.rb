#
# <Description>
#
module LoginPatch < Login
  before_create :add_confirm_token
  before_validation :create_user

  def confirmed
    provider.present? || \
      provider.nil? && confirm_token.nil?
  end

  def add_confirm_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end

  def create_user
    return if user.present?
    self.user = User.create!
  end
end

Login.include LoginPatch
