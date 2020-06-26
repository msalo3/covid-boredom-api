# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'csv'

players = JSON.parse(File.read(Rails.root.join('lib', 'seeds', 'nba_nicknames.json')))
players.each do |name, alt_names|
  nba_player = NbaPlayer.find_or_create_by name: name.downcase
  alt_names.each do |alt_name|
    nickname = Nickname.find_or_create_by name: alt_name
    NbaPlayersNickname.find_or_create_by nickname_id: nickname.id, nba_player_id: nba_player.id
  end
end

['Wedding/Anniversary', 'Blank Art Cards', 'Sympathy', 'Birthday', 'Holiday', 'Baby'].each do |cat|
  Category.find_or_create_by name: cat
end

CSV.foreach(File.join(Rails.root, 'db','cards','cardinfo.csv')).with_index(4) do |row, i|
	card = Card.create_with(
		info: row[3],
		vertical: (row[2].gsub(/\s+/, "") || "").downcase == "vertical",
		sold: (row[4].gsub(/\s+/, "") || "").downcase == "true",
    main_image: (row[5].gsub(/\s+/, "") || "").downcase == "true"
  ).find_or_create_by(name: row[1])
  
  cats = []
	if row[6]
		cat = Category.find_by(name: row[6])
		cats << cat if cat
	end
	if row[7]
		cat2 = Category.find_by(name: row[7])
		cats << cat2 if cat2
  end
  card.categories = cats
  card.save

	unless card.image.attached?
		card.image.attach(
			io: File.open(File.join(Rails.root, 'db','cards',"/#{i}.jpeg")),
			filename: "#{i}.jpeg",
			content_type: "image/jpeg"
		)
	end
end
