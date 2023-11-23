require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User validations' do
    it 'is valid with a name, email, and password' do
      user = User.create(name: 'Roy Batty', email: 'roy@replicant.net', password: 'Password')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.create(name: nil, email: 'roy@replicant.net', password: 'Password')
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = User.create(name: 'Roy Batty', password: 'Password')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = User.create(name: 'Roy Batty', email: 'roy@replicant.net')
      expect(user).not_to be_valid
    end
  end
end
