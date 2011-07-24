# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dbf_writer/version"

Gem::Specification.new do |s|
  s.name        = "dbf_writer"
  s.version     = DbfWriter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mereghost (Marcello Rocha)"]
  s.email       = ["marcello.rocha@gmail.com"]
  s.homepage    = "http://github.com/mereghost/dbf_writer"
  s.summary     = %q{DbfWriter is a library for exporting your collection of objects as BDF files }
  s.description = %q{Export your data as DBF files. This gem only writes DBF and do *NOT* read them.}

  s.rubyforge_project = ""

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'metric_fu'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

