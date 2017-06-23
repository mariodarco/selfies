# Open the Kernel modul to define methods for any class.
module Kernel
  def self_init(*variable_names)
    Selfies.generate_initializer(self, *variable_names)
  end
end
