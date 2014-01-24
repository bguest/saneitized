# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'saneitized/version'

Gem::Specification.new do |spec|
  spec.name          = 'saneitized'
  spec.version       = Saneitized::VERSION
  spec.authors       = ['Benjamin Guest']
  spec.email         = ['benguest@gmail.com']
  spec.summary       = %q{Sanely converts string values to their ruby equivalent}
  spec.description   = %q{Converts ruby hash values from strings to fixnums, floats, true and false values if it can sanely do so.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',   '~>1.5'
  spec.add_development_dependency 'rspec',     '~>2.14.1'
  spec.add_development_dependency 'rake',      '~>10.1.1'
  spec.add_development_dependency 'simplecov', '~>0.8.2'
end
