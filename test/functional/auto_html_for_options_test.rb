require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../fixture_setup'

# store default so we can revert so that other tests use default option
default_suffix = AutoHtmlFor.auto_html_for_options[:htmlized_attribute_suffix]
AutoHtmlFor.auto_html_for_options[:htmlized_attribute_suffix] = '_htmlized'

class Article < ActiveRecord::Base
  auto_html_for :body => "_to_html" do
    youtube
  end

  auto_html_for :body => "_to_image" do
    youtube_image
  end
end

class AutoHtmlForTest < Test::Unit::TestCase
  include FixtureSetup

  def test_transform_after_save
    @article = Article.new(:body => 'Yo!')
    assert_equal '<p>Yo!</p>', @article.body_htmlized
    @article.save!
    assert_equal '<p>Yo!</p>', @article.body_htmlized
  end
  
  
  def test_create_thumb_for_youtube
    @article = Article.new(:body => 'http://www.youtube.com/watch?v=O7aQtpVXYK4&feature=grec_index')
    @article.save!
    
    assert_equal %'<iframe class=\"youtube-player\" type=\"text/html\" width=\"390\" height=\"250\" src=\"http://www.youtube.com/embed/O7aQtpVXYK4\" frameborder=\"0\">\n</iframe>', @article.body_to_html
    assert_equal '<img src="http://i1.ytimg.com/vi/O7aQtpVXYK4/default.jpg" alt=""/>', @article.body_to_image
  end
  
end

# reverting to default so that other tests use default option
AutoHtmlFor.auto_html_for_options[:htmlized_attribute_suffix] = default_suffix