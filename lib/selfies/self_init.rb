module Selfies
  class SelfInit
    def self.generate(class_name, *variable_names)
      return false unless variable_names.any?

      class_name.class_eval do        
        attr_reader *variable_names

        define_method(:initialize) do |*args|
          argument_check(variable_names.count, args.count)

          variable_names.each_with_index do |variable, index|
            instance_variable_set("@#{variable}", args[index])
          end
        end

        def argument_check(expected, given)
          raise ArgumentError, "wrong number of arguments (given #{given}, expected #{expected})" unless given == expected
        end
      end
    end
  end
end
