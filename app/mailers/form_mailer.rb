class FormMailer < ApplicationMailer
  default from: 'artcardspgh@example.com', to: 'marcsalo455@gmail.com'
 
  def contact_email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    mail(subject: 'Art Cards PGH message')
  end
end
