require 'hpricot'
require 'open-uri'

AutoHtml.add_filter(:vimeo_image).with(:size => :medium) do |text, options|
  text.gsub(/http:\/\/(www.)?vimeo\.com\/([A-Za-z0-9._%-]*)((\?|#)\S+)?/) do
    vimeo_id  = $2
    size      = options[:size].to_s
    vimeo_xml = open("http://vimeo.com/api/v2/video/#{vimeo_id}.xml") { |v| Hpricot.XML(v) }
    
    (vimeo_xml/"thumbnail_#{size}").inner_html.blank? ? (vimeo_xml/"thumbnail_medium").inner_html : (vimeo_xml/"thumbnail_#{size}").inner_html
  end
end

