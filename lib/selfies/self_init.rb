module Selfies
  class SelfInit
    def self.generate(class_name, accessor, *variable_names)
      return false unless variable_names.any?

      class_name.class_eval do
        if accessor
          attr_accessor *variable_names
        else
          attr_reader *variable_names
        end

        define_method(:initialize) do |*args|
          SelfInit.argument_check(variable_names.count, args.count)

          variable_names.each_with_index do |variable, index|
            instance_variable_set("@#{variable}", args[index])
          end
        end
      end
    end

    private_class_method

    def self.argument_check(expected, given)
      raise ArgumentError, "wrong number of arguments (given #{given}, expected #{expected})" unless given == expected
    end
  end
end
