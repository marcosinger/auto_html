require File.expand_path('../../test_helper', __FILE__)
require File.expand_path('../../fixture_setup', __FILE__)

class Article < ActiveRecord::Base
  auto_html_for :body => "_htmlized" do
    simple_format
  end
  
  auto_html_for :body => "_to_html" do
    youtube
    vimeo
  end

  auto_html_for :body => "_to_image" do
    youtube_image
    vimeo_image
  end
end

class AutoHtmlForOptionsTest < Test::Unit::TestCase
  include FixtureSetup

  def test_transform_after_save
    @article = Article.new(:body => 'Yo!')
    assert_equal '<p>Yo!</p>', @article.body_htmlized
    @article.save!
    assert_equal '<p>Yo!</p>', @article.body_htmlized
  end

  def test_create_thumb_for_youtube_in_a_new_field
    @article = Article.new(:body => 'http://www.youtube.com/watch?v=O7aQtpVXYK4&feature=grec_index')
    @article.save!

    assert_equal %'<iframe class=\"youtube-player\" type=\"text/html\" width=\"390\" height=\"250\" src=\"http://www.youtube.com/embed/O7aQtpVXYK4\" frameborder=\"0\">\n</iframe>', @article.body_to_html
    assert_equal 'http://i1.ytimg.com/vi/O7aQtpVXYK4/default.jpg', @article.body_to_image
  end

  def test_create_thumb_for_vimeo_in_a_new_field
    @article = Article.new(:body => 'http://vimeo.com/14074949')
    @article.save!

    assert_equal %'<iframe src=\"http://player.vimeo.com/video/14074949?title=0&byline=0&portrait=0\" width=\"440\" height=\"248\" frameborder=\"0\"></iframe>', @article.body_to_html
    assert_equal 'http://b.vimeocdn.com/ts/819/560/81956031_200.jpg', @article.body_to_image
  end
end