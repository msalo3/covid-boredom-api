class FormController < ApplicationController
  def contact_form
    @name = form_params[:name]
    @email = form_params[:email]
    @message = form_params[:msg]
    @cards = cards(form_params[:card_ids])
    FormMailer.with(name: @name, email: @email, message: @message, cards: @cards).contact_email.deliver_later
    render json: @cards
  end

  private

  # Only allow a trusted parameter "white list" through.
  def form_params
    params.permit(:name, :email, :msg, card_ids: [])
  end

  def cards(ids)
    ids.map { |id| Card.find(id) }
  end
end
