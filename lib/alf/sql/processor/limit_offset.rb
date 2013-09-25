module Alf
  module Sql
    class Processor
      class LimitOffset < Processor
        grammar Sql::Grammar

        def initialize(limit, offset, builder = Builder.new)
          super(builder)
          @limit = limit
          @offset = offset
        end
        attr_reader :limit, :offset

        def on_nadic(sexpr)
          apply(builder.from_self(sexpr))
        end
        alias :on_union     :on_nadic
        alias :on_except    :on_nadic
        alias :on_intersect :on_nadic

        def on_select_exp(sexpr)
          sexpr  = builder.from_self(sexpr) if obc = sexpr.limit_or_offset?
          limit_clause = builder.limit_clause(limit)
          offset_clause = builder.offset_clause(offset)
          sexpr.with_push(limit_clause, offset_clause)
        end

      end # class LimitOffset
    end # class Processor
  end # module Sql
end # module Alf
