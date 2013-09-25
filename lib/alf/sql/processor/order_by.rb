module Alf
  module Sql
    class Processor
      class OrderBy < Processor
        grammar Sql::Grammar

        def initialize(ordering, builder = Builder.new)
          super(builder)
          @ordering = ordering
        end
        attr_reader :ordering

        def on_nadic(sexpr)
          call(builder.from_self(sexpr))
        end
        alias :on_union     :on_nadic
        alias :on_except    :on_nadic
        alias :on_intersect :on_nadic

        def on_select_exp(sexpr)
          if obc = sexpr.order_by_clause
            sexpr = builder.from_self(sexpr)
            call(sexpr)
          else
            needed = builder.order_by_clause(ordering, &sexpr.desaliaser)
            sexpr.dup.push(needed)
          end
        end

      end # class OrderBy
    end # class Processor
  end # module Sql
end # module Alf
