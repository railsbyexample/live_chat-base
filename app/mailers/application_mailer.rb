class ApplicationMailer < ActionMailer::Base
  include DefaultUrlOptions

  default from: 'from@example.com'
  layout 'mailer'
end
