require 'kernel'
require 'selfies/self_init'
require 'selfies/version'

module Selfies
  def self.generate_initializer(class_name, *variable_names)
    SelfInit.generate(class_name, *variable_names)
  end
end
