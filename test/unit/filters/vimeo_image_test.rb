require File.dirname(__FILE__) + '/../unit_test_helper'

class VimeoImageTest < Test::Unit::TestCase

  def test_build_image_url
    result = auto_html('http://www.vimeo.com/3300155') { vimeo_image }
    assert_equal '<img src="http://b.vimeocdn.com/ts/188/591/1885913_200.jpg" alt=""/>', result
  end

  def test_build_image_url_small
    result = auto_html('http://vimeo.com/3300155') { vimeo_image(:size => :small) }
    assert_equal '<img src="http://b.vimeocdn.com/ts/188/591/1885913_100.jpg" alt=""/>', result
  end

  def test_build_image_url_medium
    result = auto_html('http://www.vimeo.com/3300155') { vimeo_image(:size => :medium) }
    assert_equal '<img src="http://b.vimeocdn.com/ts/188/591/1885913_200.jpg" alt=""/>', result
  end

  def test_build_image_url_large
    result = auto_html('http://www.vimeo.com/3300155') { vimeo_image(:size => :large) }
    assert_equal '<img src="http://b.vimeocdn.com/ts/188/591/1885913_640.jpg" alt=""/>', result
  end

  def test_build_image_url_wrong_size
    result = auto_html('http://www.vimeo.com/3300155') { vimeo_image(:size => :wrong_size) }
    assert_equal '<img src="http://b.vimeocdn.com/ts/188/591/1885913_200.jpg" alt=""/>', result
  end
end

