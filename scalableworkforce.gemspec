Gem::Specification.new do |s|
  s.name = %q{scalableworkforce}
  s.required_ruby_version = '>= 1.9.2'
  s.version = "0.1.0"
  s.authors = ["Adam Coffman"]
  s.email = ["coffman.adam@gmail.com"]
  s.summary = %q{An interface to ScalableWorkforce.com's public API}
  s.homepage = %q{http://github.com/thecoffman/scalableworkforce}
  s.description = %q{An interface to ScalableWorkforce.com's public API. You will need an active account and login credentials from ScalableWorkforce.com to use this gem}
  s.files = [ "README.md", "LICENSE.md", "Manifest.txt" ,"lib/scalableworkforce.rb", "lib/api/client.rb", "lib/api/batchrequest.rb", "lib/api/models.rb"]
  s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
  s.add_dependency(%q<nibbler>, [">= 1.2.1"])
  s.add_dependency(%q<builder>, [">= 3.0.0"])
  s.add_dependency(%q<addressable>, [">= 2.2.6"])
end

