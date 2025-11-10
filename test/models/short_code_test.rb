require 'test_helper'

class ShortCodeTest < ActiveSupport::TestCase
  # It goes from 0 to 9
  10.times do |i|
    test "encode #{i}" do
      assert_equal i.to_s, ShortCode.encode(i)
    end
  end

  test 'encode 10' do
    assert_equal 'a', ShortCode.encode(10)
  end

  test 'encode 62' do
    assert_equal '10', ShortCode.encode(62)
  end

  test 'encode 1024' do
    assert_equal 'gw', ShortCode.encode(1024)
  end

  test 'encode 999_999' do
    assert_equal '4c91', ShortCode.encode(999_999)
  end

  test 'encode non-integer' do
    assert_raises(ArgumentError) { ShortCode.encode('10') }
    assert_raises(ArgumentError) { ShortCode.encode(10.5) }
  end

  test 'encode nil' do
    assert_raises(ArgumentError) { ShortCode.encode(nil) }
  end
end
