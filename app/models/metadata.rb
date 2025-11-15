require 'open-uri'

class Metadata
  attr_reader :doc

  def initialize(html = nil)
    @doc = Nokogiri::HTML(html)
  end

  def self.retrieve_from(url)
    new(URI.open(url))
  rescue StandardError
    nil
  end

  def attributes
    {
      title: title,
      description: description,
      image: image
    }
  end

  def title
    doc.at_css('title')&.text
  end

  def description
    meta_tag_content(property_attribute: 'description')
  end

  def image
    meta_tag_content(name_attribute: :property, property_attribute: 'og:image')
  end

  def meta_tag_content(name_attribute: :name, property_attribute: :property)
    doc.at_css("meta[#{name_attribute}='#{property_attribute}']")&.attributes&.fetch('content', nil)&.text
  end
end
