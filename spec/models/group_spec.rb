require 'rails_helper'

RSpec.describe Group, type: :model do

  describe 'Group validations' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

    it 'is valid with a name and icon' do
      group = Group.create(name: 'Test Group', icon: 'icon.png', user: user)
      expect(group).to be_valid
    end

    it 'is not valid without a name' do
      group = Group.create(name: nil, icon: 'icon.png', user: user)
      expect(group).not_to be_valid
    end

    it 'is not valid without an icon' do
      group = Group.create(name: 'Test Group', icon: nil, user: user)
      expect(group).not_to be_valid
    end
  end

  describe '#total_payments_amount' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
    let(:group) { Group.create(name: 'Test Group', icon: 'icon.png', user: user) }

    it 'returns the total amount of payments for the group' do
      payment1 = Payment.create(name: 'Payment 1', amount: 50, author: user)
      payment2 = Payment.create(name: 'Payment 2', amount: 30, author: user)

      group.payments << payment1
      group.payments << payment2

      expect(group.total_payments_amount).to eq(80)
    end

    it 'returns 0 if there are no payments for the group' do
      expect(group.total_payments_amount).to eq(0)
    end
  end
end