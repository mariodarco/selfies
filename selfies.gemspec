# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'selfies/version'

Gem::Specification.new do |spec|
  spec.name          = 'selfies'
  spec.version       = Selfies::VERSION
  spec.authors       = ['Mario D’Arco']
  spec.email         = ['mariodarco78@icloud.com']

  spec.summary       = 'A collection of macros for quicker development.'
  spec.homepage      = 'https://github.com/mariodarco/selfies'
  spec.license       = 'MIT'
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
end
