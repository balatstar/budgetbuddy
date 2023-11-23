require 'rails_helper'

RSpec.describe Payment, type: :model do

  describe 'Payment validations' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
    let(:group) { Group.create(name: 'Test Group', icon: 'icon.png', user: user) }

    it 'is valid with a name, amount, author, and group_ids' do
      payment = Payment.create(name: 'Test Payment', amount: 50, author: user, group_ids: [group.id])
      expect(payment).to be_valid
    end

    it 'is not valid without a name' do
      payment = Payment.create(name: nil, amount: 50, author: user, group_ids: [group.id])
      expect(payment).not_to be_valid
    end

    it 'is not valid without an amount' do
      payment = Payment.create(name: 'Test Payment', amount: nil, author: user, group_ids: [group.id])
      expect(payment).not_to be_valid
    end

    it 'is not valid with a negative amount' do
      payment = Payment.create(name: 'Test Payment', amount: -30, author: user, group_ids: [group.id])
      expect(payment).not_to be_valid
    end

    it 'is not valid without group_ids' do
      payment = Payment.create(name: 'Test Payment', amount: 50, author: user, group_ids: nil)
      expect(payment).not_to be_valid
    end

    it 'is not valid with an empty group_ids array' do
      payment = Payment.create(name: 'Test Payment', amount: 50, author: user, group_ids: [])
      expect(payment).not_to be_valid
    end

    it 'belongs to a group' do
      payment = Payment.create(name: 'Test Payment', amount: 50, author: user, group_ids: [group.id])
      group.payments << payment

      expect(payment.groups).to include(group)
    end
  end
end
