# Open the Kernel modul to define methods for any class.
module Kernel
  def self_init(*variable_names)
    Selfies.generate_initializer(self, *variable_names)
  end

  def selfie(*method_names)
    Selfies.generate_class_methods(self, *method_names)
  end
end
