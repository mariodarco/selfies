# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'selfies/version'

Gem::Specification.new do |spec|
  spec.name          = 'selfies'
  spec.version       = Selfies::VERSION
  spec.authors       = ['Mario D’Arco']
  spec.email         = ['mario.darco.78@gmail.com']

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

  spec.required_ruby_version = '>= 3.4'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
