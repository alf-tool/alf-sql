module Alf
  module Sql
    class Compiler < Alf::Compiler

      def initialize
        @builder = Builder.new
      end
      attr_reader :builder

      ### base

      def on_leaf_operand(expr, &fallback)
        fresh_cog(expr, builder.select_all(expr.heading, expr.name))
      end

      ### non-relational

      def on_clip(expr, compiled)
        rewrite(compiled, expr, Processor::Clip, [expr.attributes, :is_table_dee])
      end

      def on_sort(expr, compiled)
        if compiled.orderedby?(expr.ordering)
          rebind(compiled, expr)
        else
          rewrite(compiled, expr, Processor::OrderBy, [expr.ordering])
        end
      end

      ### relational

      def on_frame(expr, compiled)
        compiled = _call(parser.sort(expr, expr.total_ordering), [ compiled ])
        rewrite(compiled, expr, Processor::LimitOffset, [expr.limit, expr.offset])
      end

      def on_intersect(expr, left, right)
        rewrite(left, expr, Processor::Merge, [:intersect, right.sexpr])
      end

      def on_join(expr, left, right)
        rewrite(left, expr, Processor::Join, [right.sexpr])
      end

      def on_matching(expr, left, right)
        rewrite(left, expr, Processor::SemiJoin, [right.sexpr, false])
      end

      def on_minus(expr, left, right)
        rewrite(left, expr, Processor::Merge, [:except, right.sexpr])
      end

      def on_not_matching(expr, left, right)
        rewrite(left, expr, Processor::SemiJoin, [right.sexpr, true])
      end

      def on_page(expr, compiled)
        index, size = expr.page_index, expr.page_size
        #
        ordering = expr.total_ordering
        ordering = ordering.reverse if index < 0
        #
        compiled = _call(parser.sort(expr, ordering), [ compiled ])
        rewrite(compiled, expr, Processor::LimitOffset, [size, (index.abs - 1) * size])
      end

      def on_project(expr, compiled)
        preserving = expr.key_preserving? rescue false
        #
        compiled = rewrite(compiled, expr, Processor::Distinct) unless preserving
        compiled = self._call(parser.clip(expr, expr.stay_attributes), [ compiled ])
        #
        rebind(compiled, expr)
      end

      def on_rename(expr, compiled)
        rewrite(compiled, expr, Processor::Rename, [expr.renaming])
      end

      def on_restrict(expr, compiled)
        rewrite(compiled, expr, Processor::Where, [expr.predicate])
      end

      # def on_summarize(expr, compiled)
      #   # -> SQL's GROUP-BY
      # end

      def on_union(expr, left, right)
        rewrite(left, expr, Processor::Merge, [:union, right.sexpr])
      end

    protected

      def fresh_cog(expr, sexpr)
        Cog.new(expr, self, sexpr)
      end

      def rewrite(compiled, expr, processor, args = [])
        rewrited = processor.new(*args.push(builder)).call(compiled.sexpr)
        Cog.new(expr, self, rewrited)
      end

      def rebind(compiled, expr)
        Cog.new(expr, self, compiled.sexpr)
      end

    end # class Compilable
  end # module Sql
end # module Alf
