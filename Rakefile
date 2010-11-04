require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "dbf_writer"
  gem.summary = %Q{A simple DBF exporter for your objects}
  gem.description = %Q{export your data as DBF files. It will only write the DBF as binary data. It WON'T use any kind of manipulation of DBF files.}
  gem.email = "marcello.rocha@gmail.com"
  gem.homepage = "http://github.com/mereghost/dbf_writer"
  gem.authors = ["Mereghost"]
  gem.add_development_dependency "rspec", ">= 2.0.0"
  gem.add_development_dependency "yard", ">= 0.6.0"
  gem.add_development_dependency "bundler", ">= 1.0.0"
  gem.add_development_dependency "jeweler", ">= 1.5.0.pre5"
  gem.add_development_dependency "simplecov", ">= 0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
