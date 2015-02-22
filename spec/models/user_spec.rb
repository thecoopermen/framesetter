require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it 'ensures email address is provided' do
      expect(User.new(email: nil, password: 'password')).to_not be_valid
    end

    it 'ensures password is provided when creating a user' do
      expect(User.new(email: 'foo@bar.com', password: nil)).to_not be_valid
    end

    it 'allows password to not be set when updating a user' do
      expect(User.create(email: 'foo@bar.com', password: 'password').update_attributes(email: 'bar@foo.com')).to be_truthy
    end
  end
end
