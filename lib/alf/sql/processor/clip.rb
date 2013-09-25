module Alf
  module Sql
    class Processor
      class Clip < Processor
        grammar Sql::Grammar

        def initialize(attributes, builder = Builder.new)
          super(builder)
          @attributes = attributes
        end

        def on_select_list(sexpr)
          sexpr.select{|child|
            (child == :select_list) || @attributes.include?(child.as_name.to_sym)
          }
        end

      end # class Clip
    end # class Processor
  end # module Sql
end # module Alf
