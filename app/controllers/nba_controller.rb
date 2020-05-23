class NbaController < ApplicationController
  def players_by_letter
    players_data = nba_scraper_service.players_by_letter(players_by_letter_params[:letter])
    render json: players_data
  end

  def player_by_link
    player_data = nba_scraper_service.player_by_link(players_by_letter_params[:link])
    render json: player_data
  end

  private

  def players_by_letter_params
    params.permit(:link, :letter)
  end

  def nba_scraper_service
    @nba_scraper_service ||= NbaScraperService.new
  end
end
