# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'renewable/version'

Gem::Specification.new do |spec|
  spec.name          = 'renewable'
  spec.version       = Renewable::VERSION
  spec.authors       = ['James Thompson']
  spec.email         = %w{james@buypd.com}
  spec.summary       = %q{Provides frozen by default objects}
  spec.description   = %q{Provides frozen by default objects for more Functional style.}
  spec.homepage      = 'https://github.com/plainprogrammer/renewable'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
