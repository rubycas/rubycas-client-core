# -*- encoding: utf-8 -*-
$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'rubycas-client-core/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Matt Campbell"]
  gem.email         = ["matt@soupmatt.com"]
  gem.description   = %q{Ruby Library for interacting with a CAS Server}
  gem.summary       = %q{Ruby Library for interacting with a CAS Server}
  gem.homepage      = "https://github.com/rubycas/rubycas-client-core"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rubycas-client-core"
  gem.require_paths = ["lib"]
  gem.version       = Rubycas::Client::Core::VERSION

  gem.add_development_dependency("rspec", "~> 2.10.0")
  gem.add_development_dependency("cucumber", "~> 1.2.0")
  gem.add_development_dependency("guard", "~> 1.0.3")
  gem.add_development_dependency("guard-rspec", "~> 0.7.3")
  gem.add_development_dependency("guard-cucumber", "~> 0.8.0")
  gem.add_development_dependency("guard-bundler", "~> 0.1.3")
end
