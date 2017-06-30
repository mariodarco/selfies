module Selfies
  class SelfInit
    def self.generate(class_name, accessor, *variables)
      return false unless variables.any?

      class_name.class_eval do
        variable_names = SelfInit.variable_names(variables)
        if accessor
          attr_accessor *variable_names
        else
          attr_reader *variable_names
        end

        define_method(:initialize) do |*args|
          unless correct_argument_count?(variables, variable_names.count, args.count)
            raise ArgumentError, "wrong number of arguments (given #{args.count}, expected #{variable_names.count})"
          end

          variables.each_with_index do |variable, index|
            variable_name, default = decouple(variable)
            if variable_name == :args
              instance_variable_set("@#{variable_name}", args[index..-1] || default)
            else
              instance_variable_set("@#{variable_name}", args[index] || default)
            end
          end
        end

        private_class_method

        define_method(:correct_argument_count?) do |variables, expected, given|

          correct_argument_count = given == expected
          if variables.last.is_a? Hash
            correct_argument_count ||= given == expected - 1
          elsif variables.last == :args
            at_least = variables[0..variables.index(:args)].count
            correct_argument_count ||= given >= at_least
          end

          correct_argument_count
        end

        define_method(:decouple) do |variable|
          return [variable, nil] if !variable.is_a? Hash

          variable.keys + variable.values
        end
      end
    end

    private_class_method

    def self.variable_names(variables)
      variables.collect do |variable|
        variable.is_a?(Hash) ? variable.keys.first : variable
      end
    end
  end
end
