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

        def on_union(sexpr)
        end

        def on_except(sexpr)
        end

        def on_intersect(sexpr)
        end

        def on_select_exp(sexpr)
          sexpr  = builder.from_self(sexpr) if obc = sexpr.limit_or_offset?
          limit_clause = builder.limit_clause(limit)
          offset_clause = builder.offset_clause(offset)
          sexpr.dup.push(limit_clause).push(offset_clause)
        end

      end # class LimitOffset
    end # class Processor
  end # module Sql
end # module Alf
