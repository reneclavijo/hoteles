class ReservaMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reserva_mailer.enviar_confirmacion.subject
  #
  def enviar_confirmacion
    @greeting = "Hola desde rails"

    mail to: "rrodriguez@edutecno.com" # a quién le vamos a enviar el correo
  end
end
