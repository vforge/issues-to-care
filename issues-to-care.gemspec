$:.push File.expand_path("../lib", __FILE__)
require "issues-to-care/version"

Gem::Specification.new do |gem|
  gem.name = "issues-to-care"
  gem.version = IssuesToCare::VERSION
  gem.summary = "IssuesToCare is simple gem - a wrapper for BitBucket / GitHub issues."
  gem.description = "IssuesToCare is simple gem - a wrapper for BitBucket / GitHub issues."
  gem.license = "MIT"

  gem.files = Dir["README.md", "MIT-LICENSE", "lib/**/*.rb"]

  # https://github.com/rest-client/rest-client
  gem.add_dependency %q<rest-client>

  gem.author = "Bartosz \"V.\" Bentkowski"
  gem.email  = "bartosz.bentkowski@gmail.com"
  gem.homepage = "https://github.com/vforge/issues-to-care"
end
