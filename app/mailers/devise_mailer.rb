class DeviseMailer < Devise::Mailer
  include DefaultUrlOptions

  default from: 'from@example.com'
  layout 'mailer'
end
