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

        def on_ndadic(sexpr)
          sexpr = builder.from_self(sexpr)
          call(sexpr)
        end
        alias :on_union     :on_ndadic
        alias :on_except    :on_ndadic
        alias :on_intersect :on_ndadic

        def on_select_exp(sexpr)
          if obc = sexpr.order_by_clause
            sexpr = builder.from_self(sexpr)
            call(sexpr)
          else
            needed = builder.order_by_clause(ordering, &sexpr.qualifier_proc)
            sexpr.dup.push(needed)
          end
        end

      end # class OrderBy
    end # class Processor
  end # module Sql
end # module Alf
