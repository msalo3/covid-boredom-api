class FormMailer < ApplicationMailer
  default from: ENV['GMAIL_EMAIL'], to: ENV['GMAIL_EMAIL_TO']
 
  def contact_email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    mail(subject: 'Art Cards PGH message')
  end
end
