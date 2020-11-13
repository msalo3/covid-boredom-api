class CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  # GET /cards
  def index
    @cards = Card.order(updated_at: :desc).with_attached_image

    render json: @cards
  end

  # GET /cards/1
  def show
    render json: @card
  end

  # POST /cards
  def create
    cats = grab_categories(card_params[:categories])
    main_img_check = cats.count == 1 && card_params[:main_image]
    @card = Card.new(
      name: card_params[:name],
      info: card_params[:info],
      vertical: card_params[:vertical],
      sold: card_params[:sold],
      main_image: main_img_check,
      image: card_params[:image],
      categories: cats
    )

    if @card.save
      update_categories(cats.first.id, @card.id) if main_img_check
      render json: @card, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  def update
    if (card_params[:image] && !file?(card_params[:image]))
      delete_image if @card.image.attached?
      card_params.delete(:image)
    end

    cats = grab_categories(card_params[:categories])
    main_img_check = cats.count == 1 && card_params[:main_image]
    if @card.update(
      {name: card_params[:name],
      info: card_params[:info],
      vertical: card_params[:vertical],
      sold: card_params[:sold],
      main_image: main_img_check,
      image: card_params[:image],
      categories: cats
      }.compact!
    )

      update_categories(cats.first.id, @card.id) if main_img_check
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  def destroy
    delete_image if @card.image.attached?
    @card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.permit(:id, :name, :info, :vertical, :sold, :main_image, :image, :categories)
    end

    def file?(param)
      param.is_a?(ActionDispatch::Http::UploadedFile)
    end
  
    def delete_image
      @card.image.purge
    end

    def grab_categories(arr)
      cats = []
      arr.split(',').each do |name|
        cat = Category.where("lower(name) = ?", name.downcase).first
        cats << cat if cat
      end
      cats
    end

    def update_categories(id, card_id)
      main_cards = Card.where(main_image: true)
      main_cards.each do |m|
        next if m.id == card_id || m.categories.count > 1 || m.categories.first.id != id

        m.main_image = false
        m.save
      end
    end
end
