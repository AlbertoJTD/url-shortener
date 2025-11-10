class Link < ApplicationRecord
  include HasShortCode

  validates :url, presence: true
end
