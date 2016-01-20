# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ownlan/version'

Gem::Specification.new do |spec|
  spec.name                  = 'ownlan'
  spec.version               = Ownlan::VERSION
  spec.authors               = ['sidney']
  spec.email                 = ['shideneyu@gmail.com']
  spec.summary               = 'Ownlan aims to be a simple, concise and useful pentesting LAN poisoning suite'
  spec.description           = 'Ownlan is used to test a network against MITM attacks, and then to secure it.'
  spec.homepage              = 'https://github.com/shideneyu/ownlan'
  spec.license               = 'MIT'
  spec.required_ruby_version = '~> 2.1.2'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['ownlan']
  spec.require_paths = ['lib']

  spec.add_dependency 'packetfu'
  spec.add_dependency 'trollop'
  spec.add_dependency 'activesupport'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
