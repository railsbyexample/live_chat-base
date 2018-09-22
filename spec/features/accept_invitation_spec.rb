RSpec.feature 'AcceptInvitation', type: :feature do
  before(:each) { clear_emails }

  scenario 'the user clicks on the email link' do
    User.invite! email: 'test3@user.com'

    open_email('test3@user.com')
    current_email.click_link I18n.t('devise.mailer.invitation_instructions.accept')

    expect(page)
      .to have_content(I18n.t('devise.invitations.edit.header'))
  end

  scenario 'the user enters the correct information' do
    User.invite! email: 'test4@user.com'

    open_email('test4@user.com')
    current_email.click_link I18n.t('devise.mailer.invitation_instructions.accept')

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button I18n.t('devise.invitations.edit.submit_button')

    expect(page)
      .to have_content(I18n.t('devise.invitations.updated'))
  end

  scenario 'the user enters incomplete information' do
    User.invite! email: 'test4@user.com'

    open_email('test4@user.com')
    current_email.click_link I18n.t('devise.mailer.invitation_instructions.accept')

    fill_in 'Password', with: 'password'

    click_button I18n.t('devise.invitations.edit.submit_button')

    expect(page)
      .to have_content(I18n.t('errors.messages.confirmation', attribute: ''))
  end
end
