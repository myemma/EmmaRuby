# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'emma/version'

Gem::Specification.new do |s|
  s.name          = "emma"
  s.version       = Emma::VERSION
  s.authors       = ["Dennis Monsewicz"]
  s.email         = ["dennismonsewicz@gmail.com"]
  s.description   = %q{A simple wrapper for integration with Emma's API'}
  s.summary       = %q{A simple wrapper for integration with Emma's API}
  s.homepage      = ""

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.test_files    = `git ls-files -- {test}/*`.split '\n'
  s.require_paths = ["lib"]
  
  s.add_dependency 'httparty'
  s.add_dependency 'json'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
