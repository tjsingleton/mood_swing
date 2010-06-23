require File.expand_path("../lib/mood_swing/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "mood_swing"
  gem.version = MoodSwing::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.authors = ["TJ Singleton"]
  gem.email = "tjsingleton@vantagestreet.com"
  gem.homepage = "http://github.com/tjsingleton/mood_swing"
  gem.summary = %Q{Polymorphic behavior based on the value of an attribute}
  gem.description = %Q{Allows polymorphic behavior based on the value of an attribute by including a module dynamically.}

  gem.files = Dir["{lib}/**/*.rb", "*.rdoc",]
  gem.require_path = 'lib'
end