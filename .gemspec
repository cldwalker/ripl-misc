# -*- encoding: utf-8 -*-
require 'rubygems' unless Object.const_defined?(:Gem)

Gem::Specification.new do |s|
  s.name        = "ripl-misc"
  s.version     = "0.1.0"
  s.authors     = ["Gabriel Horner"]
  s.email       = "gabriel.horner@gmail.com"
  s.homepage    = "https://github.com/cldwalker/ripl-misc"
  s.summary = "Misc libraries for ripl"
  s.description =  "Misc libraries for ripl that have optional dependencies"
  s.required_rubygems_version = ">= 1.3.6"
  s.files = Dir.glob(%w[{lib,test}/**/*.rb bin/* [A-Z]*.{txt,rdoc,md} ext/**/*.{rb,c}]) + %w{Rakefile .gemspec .travis.yml}
  s.files += ['.rspec']
  s.extra_rdoc_files = ["README.md", "LICENSE.txt", "Upgrading.md"]
  s.license = 'MIT'
end
