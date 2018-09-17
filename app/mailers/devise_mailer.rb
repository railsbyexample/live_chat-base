class DeviseMailer < Devise::Mailer
  include DefaultUrlOptions
  layout 'mailer'
end
