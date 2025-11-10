module HasShortCode
  extend ActiveSupport::Concern

  # Override the to_param use encoded id instead of the default id
  def to_param
    ShortCode.encode(id)
  end

  class_methods do
    # Override the find method to decode the id before finding the record
    def find(id)
      super ShortCode.decode(id)
    end
  end
end
