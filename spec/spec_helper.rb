$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

require "rubygems"
require "bundler"
Bundler.setup
require "active_record"
require "mood_swing"

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => ":memory:"
)

ActiveRecord::Schema.define do
    create_table :dogs do |table|
        table.column :breed, :string
    end
end

class Dog < ActiveRecord::Base
  define_attribute_methods
  extend MoodSwing

  mood_trigger 'breed'

  def bark
    'woof'
  end

  module HoundExtension
    def bark
      "Hoooooowl"
    end
  end
end