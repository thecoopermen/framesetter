class User < ActiveRecord::Base
  has_secure_password

  has_many :comps

  validates :email, presence: true
end
