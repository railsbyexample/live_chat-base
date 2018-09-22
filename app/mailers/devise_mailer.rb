class DeviseMailer < Devise::Mailer
  default from: 'mess.ruby@gmail.com'
  layout 'mailer'
end
