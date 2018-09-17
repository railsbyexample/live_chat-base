class ApplicationMailer < ActionMailer::Base
  include DefaultUrlOptions
  default from: 'mess.ruby@gmail.com'
  layout 'mailer'
end
