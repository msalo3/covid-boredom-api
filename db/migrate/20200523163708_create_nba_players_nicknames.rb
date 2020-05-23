class CreateNbaPlayersNicknames < ActiveRecord::Migration[5.2]
  def change
    create_table :nba_players_nicknames do |t|
      t.belongs_to :nickname
      t.belongs_to :nba_player
    end
  end
end
