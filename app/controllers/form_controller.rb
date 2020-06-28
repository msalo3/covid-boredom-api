class FormController < ApplicationController
  def contact_form
    @name = form_params[:name]
    @email = form_params[:email]
    @message = form_params[:msg]
    FormMailer.with(name: @name, email: @email, message: @message).contact_email.deliver_later
    render json: @cards
  end

  private
    # Only allow a trusted parameter "white list" through.
    def form_params
      params.permit(:name, :email, :msg)
    end
end
