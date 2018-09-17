class DeviseMailer < Devise::Mailer
  include DefaultUrlOptions
  default from: 'mess.ruby@gmail.com'
  layout 'mailer'
end
