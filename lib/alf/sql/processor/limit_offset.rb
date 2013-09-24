module Alf
  module Sql
    module Processor
      class LimitOffset < MainSelectRewriter
        grammar Sql::Grammar

        def initialize(limit, offset, builder = Builder.new)
          @limit = limit
          @offset = offset
          @builder = builder
        end
        attr_reader :limit, :offset, :builder

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
    end # module Processor
  end # module Sql
end # module Alf
