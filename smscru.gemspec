# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smscru/version'

Gem::Specification.new do |spec|
  spec.name          = 'smscru'
  spec.version       = Smscru::VERSION
  spec.authors       = ['Sergey Nartimov']
  spec.email         = ['just.lest@gmail.com']
  spec.description   = %q{Ruby interface to the smsc.ru SMS gateway service.}
  spec.summary       = %q{Ruby interface to the smsc.ru SMS gateway service.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.0.8'
end
