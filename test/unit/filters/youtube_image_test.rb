require File.dirname(__FILE__) + '/../unit_test_helper'

class YouTubeImageTest < Test::Unit::TestCase

  def test_transform
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o') { youtube_image }
    assert_equal '<img src="http://i1.ytimg.com/vi/BwNrmYRiX_o/default.jpg" alt=""/>', result
  end
end