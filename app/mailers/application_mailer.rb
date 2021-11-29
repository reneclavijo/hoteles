class ApplicationMailer < ActionMailer::Base
  default from: 'rene.clavijo@outlook.com' # desde dónde se va a enviar el correo
  layout 'mailer'
end
