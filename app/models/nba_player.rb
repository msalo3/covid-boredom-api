class NbaPlayer < ApplicationRecord
  has_and_belongs_to_many :nicknames
end
