module Selfies
  class SelfInit
    def self.generate(class_name, accessor, *variables)
      return false unless variables.any?

      variable_names = variables.collect { |v| v.keys.first rescue v }

      class_name.class_eval do
        if accessor
          attr_accessor *variable_names
        else
          attr_reader *variable_names
        end

        define_method(:initialize) do |*args|
          tolerance = variables.last.is_a? Hash
          SelfInit.argument_check(variable_names.count, args.count, tolerance)


          variables.each_with_index do |variable, index|
            variable_name, default = SelfInit.decouple(variable)
            instance_variable_set("@#{variable_name}", args[index] || default)
          end
        end
      end
    end

    private_class_method

    def self.argument_check(expected, given, tolerance = false)
      if tolerance
        correct_argument_count = (given == expected) || (given == expected - 1)
      else
        correct_argument_count = (given == expected)
      end

      unless correct_argument_count
        raise ArgumentError, "wrong number of arguments (given #{given}, expected #{expected})"
      end
    end

    def self.decouple(variable)
      return [variable, nil] if !variable.is_a? Hash

      variable.keys + variable.values
    end
  end
end
