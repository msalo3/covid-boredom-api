# frozen_string_literal: true

class NbaScraperService
  require 'openssl'
  require 'open-uri'
  require 'pry'

  def initialize
  end

  def players_by_letter(letter)
    url = "https://www.basketball-reference.com/players/#{letter}"
    Rails.logger.info url
    doc = Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))

    cells = []
    doc.search('//tr').each_with_index do |cell, index|
      Rails.logger.info cell if index == 1
      next if index == 0
      obj = {}
      name_cell = cell.search('//th')[index + 7]
      obj[:name] = name_cell.content
      obj[:link] = name_cell.children.first['href']
      vals = cell.search('//td').map do |node|
        key = node['data-stat']
        obj[key.to_sym] = node.content
      end
      cells << obj
    end

    cells
  end

  def player_by_link(link)
    url = "https://www.basketball-reference.com#{link}"
    doc = Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
    
    data = {}
    table = doc.css(".table_wrapper").first

    h = table.css('.section_heading > h2').text
    data[h.to_sym] = []

    headers = []
    table.css('thead > tr > th').each do |head|
      headers << head.text
    end 
    
    rows = table.css('.table_outer_container > .table_container > table > tbody > tr')
    rows.each do |row|
      row_item = {}
      row_heading = row.css('th')
      next if row_heading.first.nil?
      row_item[headers[0].to_sym] = row_heading.first.content
      
      row.css('td').each_with_index do |node, index|
        row_item[headers[index + 1].to_sym] = node.content
      end

      data[h.to_sym] << row_item
    end

    data
  end
end