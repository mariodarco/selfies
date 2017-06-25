# Open the Kernel modul to define methods for any class.
module Kernel
  extend Gem::Deprecate

  def attr_accessor_init(*variable_names)
    Selfies.generate_initializer(self, true, *variable_names)
  end

  def attr_reader_init(*variable_names)
    Selfies.generate_initializer(self, false, *variable_names)
  end

  def self_init(*variable_names)
    attr_reader_init(*variable_names)
  end
  deprecate :self_init, :attr_reader_init, 2017, 7

  def selfie(*method_names)
    Selfies.generate_class_methods(self, *method_names)
  end
end
