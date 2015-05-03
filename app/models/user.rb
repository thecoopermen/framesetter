class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :comps
  has_many :exports

  validates_presence_of :email, unless: :guest?
end
