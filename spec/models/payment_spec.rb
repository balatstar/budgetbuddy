require 'rails_helper'

RSpec.describe Payment, type: :model do

  describe 'Payment validations' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
    let(:group) { Group.create(name: 'Test Group', icon: 'icon.png', user: user) }

    it 'is valid with a name, amount, and author' do
      payment = Payment.create(name: 'Test Payment', amount: 50, author: user)
      expect(payment).to be_valid
    end

    it 'is not valid without a name' do
      payment = Payment.create(name: nil, amount: 50, author: user)
      expect(payment).not_to be_valid
    end

    it 'is not valid without an amount' do
      payment = Payment.create(name: 'Test Payment', amount: nil, author: user)
      expect(payment).not_to be_valid
    end

    it 'is not valid with a negative amount' do
      payment = Payment.create(name: 'Test Payment', amount: -30, author: user)
      expect(payment).not_to be_valid
    end

    it 'belongs to a group' do
      payment = Payment.create(name: 'Test Payment', amount: 50, author: user)
      group.payments << payment

      expect(payment.groups).to include(group)
    end
  end
end
