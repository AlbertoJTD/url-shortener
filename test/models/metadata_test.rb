require 'test_helper'

class MetadataTest < ActiveSupport::TestCase
  test 'title' do
    metadata = Metadata.new('<title>Test</title>')
    assert_equal 'Test', metadata.title
  end

  test 'missing title' do
    metadata = Metadata.new('<something>Something</something>')
    assert_nil metadata.title
  end

  test 'description' do
    metadata = Metadata.new('<meta name="description" content="Test">')
    assert_equal 'Test', metadata.description
  end

  test 'missing description' do
    metadata = Metadata.new('<meta name="description">')
    assert_nil metadata.description
  end

  test 'image' do
    metadata = Metadata.new('<meta property="og:image" content="https://example.com/image.jpg">')
    assert_equal 'https://example.com/image.jpg', metadata.image
  end

  test 'missing image' do
    metadata = Metadata.new('<meta name="og:image">')
    assert_nil metadata.image
  end
end
