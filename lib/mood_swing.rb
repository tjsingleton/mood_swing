# Allows polymorphic behavior based on the value of an attribute by including a module dynamically.
module MoodSwing

  # reader is the value to use as the basis of the included module. The convention for naming the include is:
  # YourClass::YourNameExtension
  #
  # An example would be:
  #
  # class Dog < ActiveRecord::Base
  #   mood_trigger 'breed'
  #
  #   def bark
  #     puts 'woof'
  #   end
  # end
  #
  # module Dog::HoundExtension
  #   def bark
  #     puts 'Hoooooowl'
  #   end
  # end
  #
  # When a instance of dog is initialized the breed attribute is read and it's value is used to extend the current
  # instance's behavior with the module matching following the previously mentioned convention. If the Dog instance's
  # breed was "Hound" then it would be extended with the Dog::HoundExtension. Now when you call @dog.bark, your dog will
  # howl instead of woof.
  #
  # The module is updated when the attribute changes. An example of the behavior to expect with a new object is:
  #
  # spot = Dog.new
  # spot.bark
  # => "woof"
  # spot.breed = "hound"
  # spot.bark
  # => 'Hoooooowl'
  #
  # If your attribute writer is different from the reader, then you can pass in :writer => "your_writer_method" and it
  # will use that. This is the case when using a polymorphic belongs_to accessor as the attribute.
  #
  # belongs_to 'body', :polymorphic => true
  # mood_trigger 'body_type', :writer => 'body'
  #
  # You can pass it an option, :module_format. The default is "%sExtension"
  def mood_trigger(reader, options ={})
    options[:writer] ||= reader
    options[:module_format] ||= "%sExtension"

    define_mood_writer(options[:writer], reader)
    define_mood_loader(options[:module_format], reader)

    class_eval do
      alias_method_chain "#{options[:writer]}=", 'extension'
      after_initialize "#{reader}_extension!"
    end
  end

  def find_module(name)
    self.const_defined?(name) ? self.const_get(name) : self.const_missing(name)
  rescue NameError
  end

  def define_mood_writer(writer, reader)
    define_method("#{writer}_with_extension=") do |value|
      self.send "#{writer}_without_extension=", value
      self.send "#{reader}_extension!"
      self.send reader
    end
  end

  def define_mood_loader(module_format, reader)
    define_method("#{reader}_extension!") do
      return unless kind = self[reader]
      extension_name = module_format % kind.classify
      if extension = self.class.find_module(extension_name)
        self.extend extension
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  extend MoodSwing
end