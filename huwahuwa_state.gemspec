# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huwahuwa_state/version'

Gem::Specification.new do |spec|
  spec.name          = "huwahuwa_state"
  spec.version       = HuwahuwaState::VERSION
  spec.authors       = ["jiikko"]
  spec.email         = ["n905i.1214@gmail.com"]
  spec.summary       = %q{State machines for Ruby.}
  spec.description   = %q{State machines for Ruby.}
  spec.homepage      = "https://github.com/jiikko/huwahuwa_state"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry"
  spec.add_dependency "activerecord", ">= 4.1"
  spec.add_dependency 'activesupport'
end
