module Selfies
  class SelfInit
    def self.generate(class_name, accessor, *variables)
      return false unless variables.any?

      class_name.class_eval do
        variable_names = SelfInit.variable_names(variables)

        SelfInit.access_variables(class_name, accessor, variable_names)

        define_method(:initialize) do |*args|
          SelfInit.argument_guard(variables, variable_names.count, args.count)

          variables.each_with_index do |variable, index|
            variable_name, default = SelfInit.decouple(variable)
            value = variable_name == :args ? args[index..-1] : args[index]
            instance_variable_set("@#{variable_name}", value || default)
          end
        end
      end
    end

    def self.access_variables(class_name, accessor, variable_names)
      class_name.send(
        (accessor ? :attr_accessor : :attr_reader),
        *variable_names
      )
    end

    def self.argument_guard(all_variables, expected, given)
      unless correct_argument_count?(all_variables, expected, given)
        raise(
          ArgumentError,
          "wrong number of arguments (given #{given}, expected #{expected})"
        )
      end
    end

    def self.correct_argument_count?(all_variables, expected, given)
      final_variable = all_variables.last
      correct_argument_count = given == expected
      if final_variable.is_a? Hash
        correct_argument_count ||= given == expected - 1
      elsif final_variable == :args
        at_least = all_variables[0..all_variables.index(:args)].count
        correct_argument_count ||= given >= at_least
      end

      correct_argument_count
    end

    def self.decouple(variable)
      return [variable, nil] unless variable.is_a? Hash

      variable.keys + variable.values
    end

    def self.variable_names(variables)
      variables.collect do |variable|
        variable.is_a?(Hash) ? variable.keys.first : variable
      end
    end
  end
end
