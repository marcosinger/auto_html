Gem::Specification.new do |gem|
  gem.name = 'marcosinger-auto_html'
  gem.version = '1.3.4'
  gem.date = Date.today.to_s

  gem.summary = "Transform URIs to appropriate markup"
  gem.description = "Automatically transforms URIs (via domain) and includes the destination resource (Vimeo, YouTube movie, image, ...) in your document"

  gem.authors  = ['Marco Antônio Singer', 'Dejan Simic']
  gem.email    = ['markaum@gmail.com', 'desimic@gmail.com']
  gem.homepage = 'http://github.com/marcosinger/auto_html'

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*',
                  'README*', 'LICENSE'] & `git ls-files -z`.split("\0")


  gem.add_dependency 'hpricot',  '>= 0.8.4'
end

