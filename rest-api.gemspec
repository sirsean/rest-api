$:.push File.expand_path("../lib", __FILE__)
require "rest/api"

spec = Gem::Specification.new do |s|
  s.name = 'rest-api'
  s.version = 0.1
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = false
  s.summary = "A base class for wrapping HTTP services in Ruby-friendly classes"
  s.description = "A base class for wrapping HTTP services in Ruby-friendly classes, for clients"
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
  s.author = "Sean Schulte"
  s.email = "sirsean@gmail.com"
  s.homepage = "http://vikinghammer.com"
  s.required_ruby_version = ">= 1.9"
  s.files = %w(README.md Rakefile) + Dir["{lib,bin,spec,doc}/**/*"]
  s.test_files= Dir.glob('test/*_spec.rb')
  s.require_path = "lib"
end

