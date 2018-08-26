RSpec.feature 'InviteUser', type: :feature do
  before { Capybara.app_host = 'http://test-tenant.localhost:3000' }
  after { Capybara.app_host = 'http://localhost:3000' }

  before(:each) { clear_emails }
  before(:each) do
    Apartment::Tenant.switch 'test-tenant' do
      user = FactoryBot.create :user, admin_level: :owner
      sign_in user
    end
  end

  scenario 'an owner creates an invitation' do
    visit '/users/invitation/new'
    fill_in 'Email', with: 'test@user.com'
    click_button I18n.t('devise.invitations.new.submit_button')

    # Notifies the admin
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
