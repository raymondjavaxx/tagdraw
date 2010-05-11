$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'tagdraw'

files = ["README*", "LICENSE",  "lib/**/*"].map do |glob|
  Dir[glob]
end.flatten

spec = Gem::Specification.new do |s|
  s.name = "tagdraw"
  s.version = Tagdraw::VERSION
  s.author = "Ramon Torres"
  s.email = "raymondjavaxx@gmail.com"
  s.summary = "GML to image utility"
  s.homepage = "http://github.com/thoughtbot/paperclip"
  s.description = "Graffiti Markup Language to image"
  s.platform = Gem::Platform::RUBY
  s.files = files
  s.require_path = "lib"
  s.has_rdoc = true
  #s.extra_rdoc_files = Dir["README*"]
  #s.rdoc_options << '--line-numbers' << '--inline-source'
  #s.requirements << "ImageMagick" << "Nokogiri"
end
