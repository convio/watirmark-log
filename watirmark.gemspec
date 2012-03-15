$:.unshift File.expand_path("../lib", __FILE__)
require "watirmark_log/version"

Gem::Specification.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "watirmark-log"
  version = WatirmarkLog::Version::STRING
  gem.version = version
  gem.homepage = "http://github.com/kylemartinez/watirmark-log"
  gem.license = "MIT"
  gem.summary = %Q{watirmark-log is a gem for logging}
  gem.description = %Q{watirmark-log allows you to use logging to help debug your code}
  gem.email = "kmartinez@convio.com"
  gem.authors = ["Kyle Martinez"]
  gem.files = FileList["[A-Z]*.*", "{lib,test,spec}/**/*"]
  gem.add_dependency("colored")
end