RSpec.feature 'InviteUser', type: :feature do
  before(:each) { clear_emails }
  before(:each) do
    user = FactoryBot.create :user
    sign_in user
  end

  scenario 'a user creates an invitation' do
    visit '/users/invitation/new'
    fill_in 'Email', with: 'test@user.com'
    click_button I18n.t('devise.invitations.new.submit_button')

    # Notifies the inviter
    expect(page)
      .to have_text(
        I18n.t(
          'devise.invitations.send_instructions',
          email: 'test@user.com'
        )
      )

    # Notifies the invitee
    open_email('test@user.com')

    expect(current_email)
      .to have_content(I18n.t('devise.mailer.invitation_instructions.accept'))
  end
end
