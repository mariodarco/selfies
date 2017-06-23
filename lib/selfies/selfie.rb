module Selfies
  class Selfie
    def self.generate(class_name, *method_names)
      class_name.class_eval do
        method_names.each do |method_name|
          define_singleton_method(method_name) do |*args|
            new(*args).public_send(method_name)
          end
        end
      end
    end
  end
end
