class Link < ApplicationRecord
  include HasShortCode

  validates :url, presence: true

  def increment!
    self.views_count += 1
    save!
  end
end
