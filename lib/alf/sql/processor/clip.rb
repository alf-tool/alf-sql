module Alf
  module Sql
    class Processor
      class Clip < Processor

        def initialize(attributes, on_empty = :is_table_dee, builder = Builder.new)
          super(builder)
          @attributes = attributes
          @on_empty = on_empty
        end
        attr_reader :attributes, :on_empty

        def on_select_exp(sexpr)
          catch(:empty){ return super(sexpr) }
          send("select_#{on_empty}", sexpr)
        end

        def on_select_list(sexpr)
          result = sexpr.select{|child|
            (child == :select_list) or
            attributes.include?(child.as_name.to_sym)
          }
          (result.size==1) ? throw(:empty) : result
        end

      private

        def select_is_table_dee(sexpr)
          builder.select_is_table_dee(select_star(sexpr))
        end

        def select_star(sexpr)
          All.new.call(Star.new.call(sexpr))
        end

      end # class Clip
    end # class Processor
  end # module Sql
end # module Alf
