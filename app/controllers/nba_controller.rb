class NbaController < ApplicationController
  def players_by_letter
    players_data = nba_scraper_service.players_by_letter(players_by_letter_params[:letter])
    render json: players_data
  end

  def player_by_link
    player_data = nba_scraper_service.player_by_link(players_by_letter_params[:link])
    render json: player_data
  end

  def player_image
    player_data = nba_scraper_service.player_image(players_by_letter_params[:name])
    render json: player_data
  end

  def nicknames
    if players_by_letter_params[:id]
      @nba_player = NbaPlayer.find(players_by_letter_params[:id])
    else
      @nba_player = NbaPlayer.find_by(name: players_by_letter_params[:name])
    end

    unless @nba_player
      render json: "No player found", :status => 404
    else
      render json: @nba_player.nicknames
    end
  end

  private

  def players_by_letter_params
    params.permit(:link, :letter, :name, :id)
  end

  def nba_scraper_service
    @nba_scraper_service ||= NbaScraperService.new
  end
end
