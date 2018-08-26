RSpec.feature 'AcceptInvitation', type: :feature do
  before { Capybara.app_host = 'http://test-tenant.localhost:3000' }
  after { Capybara.app_host = 'http://localhost:3000' }

  before(:each) { clear_emails }

  scenario 'the user clicks on the email link' do
    Apartment::Tenant.switch 'test-tenant' do
      User.invite! email: 'test3@user.com'
    end

    open_email('test3@user.com')
    current_email.click_link I18n.t('devise.mailer.invitation_instructions.accept')

    expect(page)
      .to have_content(I18n.t('devise.invitations.edit.header'))
  end

  scenario 'the user enters the correct information' do
    Apartment::Tenant.switch 'test-tenant' do
      User.invite! email: 'test4@user.com'
    end

    open_email('test4@user.com')
    current_email.click_link I18n.t('devise.mailer.invitation_instructions.accept')

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button I18n.t('devise.invitations.edit.submit_button')

    expect(page)
      .to have_content(I18n.t('devise.invitations.updated'))
  end

  scenario 'the user enters incomplete information' do
    Apartment::Tenant.switch 'test-tenant' do
      User.invite! email: 'test4@user.com'
    end

    open_email('test4@user.com')
    current_email.click_link I18n.t('devise.mailer.invitation_instructions.accept')

    fill_in 'Password', with: 'password'

    click_button I18n.t('devise.invitations.edit.submit_button')

    expect(page)
      .to have_content(I18n.t('errors.messages.confirmation', attribute: ''))
  end
end
