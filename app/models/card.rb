class Card < ApplicationRecord
  has_many :categories

  has_one_attached :image
end
