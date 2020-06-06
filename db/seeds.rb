# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

players = JSON.parse(File.read(Rails.root.join('lib', 'seeds', 'nba_nicknames.json')))
players.each do |name, alt_names|
  nba_player = NbaPlayer.find_or_create_by name: name.downcase
  alt_names.each do |alt_name|
    nickname = Nickname.find_or_create_by name: alt_name
    NbaPlayersNickname.find_or_create_by nickname_id: nickname.id, nba_player_id: nba_player.id
  end
end

['Anniversary/Wedding', 'Blank Art Cards', 'Sympathy', 'Birthday', 'Holiday', 'Baby'].each do |cat|
  Category.find_or_create_by name: cat
end