# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'encrypted_id/version'

Gem::Specification.new do |s|
  s.name        = 'encrypted_id'
  s.version     = EncryptedId::VERSION
  s.authors     = ['Nils Caspar']
  s.email       = ['ncaspar@me.com']
  s.homepage    = 'https://github.com/pencil/encrypted_id'
  s.license     = 'MIT'
  s.summary     = 'Allows you to encrypt the ID of your ActiveRecord model.'
  s.description = 'Sometimes you don\'t want your users to see the actual ID of your databases entries. This gem allows you to hide the ID.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 2.12'
  s.add_development_dependency 'sqlite3', '~> 1.3'

  s.add_runtime_dependency 'activerecord', '>= 3.0.0'
end
