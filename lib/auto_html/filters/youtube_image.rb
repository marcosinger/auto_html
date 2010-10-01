AutoHtml.add_filter(:youtube_image) do |text|
   text.gsub(/http:\/\/(www.)?youtube\.com\/watch\?v=([A-Za-z0-9._%-]*)(\&\S+)?/) do
     "http://i1.ytimg.com/vi/#{$2}/default.jpg"
   end
 end
