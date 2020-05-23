class CreateNbaPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :nba_players do |t|
      t.string :name

      t.timestamps
    end
  end
end
