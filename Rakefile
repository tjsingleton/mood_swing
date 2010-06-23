require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mood_swing #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require "bundler"
Bundler.setup

gemspec = eval(File.read("mood_swing.gemspec"))

desc "Build gem"
task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["mood_swing.gemspec"] do
  system "gem build mood_swing.gemspec"
  system "gem install mood_swing-#{MoodSwing::VERSION}.gem"
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