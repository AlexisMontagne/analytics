# -*- encoding: utf-8 -*-
require File.expand_path('../lib/analytics/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexis Montagne"]
  gem.email         = ["alexis.montagne@gmail.com"]
  gem.description   = %q{A Ruby interface to the Google Analytics API}
  gem.summary       = %q{Basic implementation of an ruby interface to the Analytics API}
  gem.homepage      = "http://www.github.com/AlexisMontagne/analytics"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "analytics"
  gem.require_paths = ["lib"]
  gem.version       = Analytics::VERSION

  gem.add_runtime_dependency("multi_json")
  gem.add_runtime_dependency("oauth2")
  gem.add_development_dependency("rspec")
  gem.add_development_dependency("rake")
  gem.add_development_dependency("mocha")
end
