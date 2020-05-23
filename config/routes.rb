Rails.application.routes.draw do
  resources :chats

  get '/nba/players_by_letter/:letter', to: 'nba#players_by_letter'
  get '/nba/player_by_link', to: 'nba#player_by_link'

  get '/nba/nicknames', to: 'nba#nicknames'
end
