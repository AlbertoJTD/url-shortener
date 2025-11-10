class Link < ApplicationRecord
  include HasShortCode

  has_many :views, dependent: :destroy
  validates :url, presence: true

  def increment!
    self.views_count += 1
    save!
  end
end
