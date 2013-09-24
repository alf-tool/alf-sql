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
          items = sexpr.sexpr_body.select{|item|
            @attributes.include?(item.as_name.to_sym)
          }
          items.unshift(:select_list)
        end

      end # class Clip
    end # class Processor
  end # module Sql
end # module Alf
