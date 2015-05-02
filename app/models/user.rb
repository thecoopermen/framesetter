class User < ActiveRecord::Base
  has_secure_password

  has_many :comps

  validates :email, presence: true

  before_create :change_auth_token

  def login!(password)
    change_auth_token if authenticate(password)
  end

private

  def change_auth_token
    if persisted?
      update_attribute(:auth_token, SecureRandom.hex)
    else
      self.auth_token = SecureRandom.hex
    end
  end
end
