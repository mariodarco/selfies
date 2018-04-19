# frozen_string_literal: true

require 'kernel'
require 'selfies/self_init'
require 'selfies/selfie'
require 'selfies/version'

# Index of the Selfies utilities
module Selfies
  def self.generate_initializer(class_name, accessor, *variable_names)
    SelfInit.generate(class_name, accessor, *variable_names)
  end

  def self.generate_class_methods(class_name, *method_names)
    Selfie.generate(class_name, *method_names)
  end
end
