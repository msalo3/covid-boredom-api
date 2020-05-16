# frozen_string_literal: true

class Chat < ApplicationRecord
  has_many :messages, dependent: :restrict_with_exception
end
