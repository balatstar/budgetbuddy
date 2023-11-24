require 'rails_helper'

RSpec.feature 'Payments', type: :feature do
  scenario 'user views payments index' do
    user = create_user_and_login
    group = create_group(user)
    payment = create_payment(group, user)

    visit group_payments_path(group)

    expect(page).to have_content('Payments')
    expect(page).to have_content(group.name)
    expect(page).to have_content(payment.name)
    expect(page).to have_content(number_to_currency(payment.amount))
  end

  scenario 'user creates a new payment' do
    user = create_user_and_login
    group = create_group(user)

    visit new_group_payment_path(group)

    fill_in 'payment_name', with: 'New Payment'
    fill_in 'payment_amount', with: 50

    # Select the group from the collection select
    select group.name, from: 'payment_group_ids'

    click_button 'Create Payment'

    expect(page).to have_content('Payment was successfully created.')
    expect(page).to have_content('New Payment')
    expect(page).to have_content(number_to_currency(50))
  end

  # Helper method to create a user and log in
  def create_user_and_login
    user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    login_as(user, scope: :user)
    user
  end

  # Helper method to create a group associated with the given user
  def create_group(user)
    Group.create(name: 'Test Group', icon: 'test_icon', user:)
  end

  # Helper method to create a payment associated with the given group and user
  def create_payment(group, user)
    Payment.create(
      name: 'Test Payment',
      amount: 25,
      author: user,
      group_ids: [group.id]
    )
  end
end
