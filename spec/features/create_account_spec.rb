require 'rails_helper'

RSpec.feature 'CreateAccount', type: :feature do
  scenario 'User enters correct data' do
    visit '/accounts/new'

    fill_in 'Subdomain', with: 'new-account'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Create account!'

    expect(page).to have_text('successfully created')
  end

  scenario 'User enters incomplete account data' do
    visit '/accounts/new'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Create account!'

    expect(page).to have_text("Subdomain can't be blank")
  end

  scenario 'User enters incomplete user data' do
    visit '/accounts/new'

    fill_in 'Subdomain', with: 'new-account'

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Create account!'

    expect(page).to have_text("Email can't be blank")
  end
end
