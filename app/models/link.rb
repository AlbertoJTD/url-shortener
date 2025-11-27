class Link < ApplicationRecord
  include HasShortCode

  belongs_to :user, optional: true
  has_many :views, dependent: :destroy
  validates :url, presence: true

  after_create_commit if: :url_previously_changed? do
    MetadataJob.perform_later(to_param)
  end

  def increment!
    self.views_count += 1
    save!
  end

  def domain
    URI.parse(url).host
  rescue URI::InvalidURIError
    nil
  end

  def editable_by?(user)
    return false if user.blank?

    user.id == user_id
  end
end
