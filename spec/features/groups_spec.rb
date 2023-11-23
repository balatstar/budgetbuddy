require 'rails_helper'

RSpec.feature 'Groups', type: :feature do
  scenario 'user views the group list' do
    user = create_user_and_login
    group = create_group(user)

    visit groups_path

    expect(page).to have_content('Categories')
    expect(page).to have_content(group.name)
    expect(page).to have_content(number_to_currency(group.total_payments_amount))
  end

  scenario 'user creates a new group' do
    create_user_and_login

    visit new_group_path

    fill_in 'group_name', with: 'New Group'
    fill_in 'group_icon', with: 'icon.png'

    click_button 'Save Category'

    expect(page).to have_content('Group was successfully created.')
    expect(page).to have_content('New Group')
  end

  # Helper method to create a user and log in
  def create_user_and_login
    user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    login_as(user, scope: :user)
    user
  end

  # Helper method to create a group associated with the given user
  def create_group(user)
    group = Group.create(name: 'Test Group', icon: 'icon.png', user: user)
    group
  end
end
