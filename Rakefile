require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mood_swing"
    gem.summary = %Q{Polymorphic behavior based on the value of an attribute}
    gem.description = %Q{Allows polymorphic behavior based on the value of an attribute by including a module dynamically.}
    gem.email = "tjsingleton@vantagestreet.com"
    gem.homepage = "http://github.com/tjsingleton/mood_swing"
    gem.authors = ["TJ Singleton"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'

  desc "Run the code examples in spec"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "./spec/**/*_spec.rb"
  end

  desc "Run all examples with RCov"
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.pattern = "./spec/**/*_spec.rb"
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec']
  end

  task :default => :spec
rescue LoadError
  puts "RSpec require for testing."
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mood_swing #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
