class NbaController < ApplicationController
  def players_by_letter
    players_data = nba_scraper_service.players_by_letter(nba_player_params[:letter])
    render json: players_data
  end

  def player_by_link
    player_data = nba_scraper_service.player_by_link(nba_player_params[:link])
    render json: player_data
  end

  def player_image
    player_data = nba_scraper_service.player_image(nba_player_params[:name], nba_player_params[:amount])
    render json: player_data
  end

  def nicknames
    if nba_player_params[:id]
      @nba_player = NbaPlayer.find(nba_player_params[:id])
    else
      @nba_player = NbaPlayer.find_by(name: nba_player_params[:name])
    end

    unless @nba_player
      render json: "No player found", :status => 404
    else
      render json: @nba_player.nicknames
    end
  end

  private

  def nba_player_params
    params.permit(:link, :letter, :name, :id, :amount)
  end

  def nba_scraper_service
    @nba_scraper_service ||= NbaScraperService.new
  end
end
