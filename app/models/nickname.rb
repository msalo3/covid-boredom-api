class Nickname < ApplicationRecord
  has_and_belongs_to_many :nba_players
end
