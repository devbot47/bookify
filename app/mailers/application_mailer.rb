class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@bookify.com"
  layout "mailer"
end
