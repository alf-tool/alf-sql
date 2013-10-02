module Alf
  module Sql
    class Compiler < Alf::Compiler

      def join(plan)
        Builder.new
      end

      def supports_reuse?
        true
      end

      def reuse(plan, cog)
        rewrite(plan, cog.expr, cog, Processor::Requalify, [])
      end

      def compile(plan, expr, compiled, usage_count)
        cog = super
        if (usage_count > 1) and cog.should_be_reused?
          cog = rewrite(plan, cog.expr, cog, Processor::FromSelf, [])
        end
        cog
      end

      ### base

      def on_leaf_operand(plan, expr)
        fresh_cog(expr, builder(plan).select_all(expr.heading, expr.name))
      end

      ### non-relational

      def on_clip(plan, expr, compiled)
        rewrite(plan, expr, compiled, Processor::Clip, [expr.attributes, :is_table_dee])
      end

      def on_sort(plan, expr, compiled)
        if compiled.orderedby?(expr.ordering)
          rebind(plan, expr, compiled)
        else
          rewrite(plan, expr, compiled, Processor::OrderBy, [expr.ordering])
        end
      end

      ### relational

      def on_frame(plan, expr, compiled)
        compiled = plan.recompile(compiled){|p|
          p.sort(expr.operand, expr.total_ordering)
        }
        rewrite(plan, expr, compiled, Processor::LimitOffset, [expr.limit, expr.offset])
      end

      def on_intersect(plan, expr, left, right)
        rewrite(plan, expr, left, Processor::Merge, [:intersect, right.sexpr])
      end

      def on_join(plan, expr, left, right)
        rewrite(plan, expr, left, Processor::Join, [right.sexpr])
      end

      def on_matching(plan, expr, left, right)
        rewrite(plan, expr, left, Processor::SemiJoin, [right.sexpr, false])
      end

      def on_minus(plan, expr, left, right)
        rewrite(plan, expr, left, Processor::Merge, [:except, right.sexpr])
      end

      def on_not_matching(plan, expr, left, right)
        rewrite(plan, expr, left, Processor::SemiJoin, [right.sexpr, true])
      end

      def on_page(plan, expr, compiled)
        index, size = expr.page_index, expr.page_size
        compiled = plan.recompile(compiled){|p|
          ordering = expr.total_ordering
          ordering = ordering.reverse if index < 0
          p.sort(expr.operand, ordering)
        }
        rewrite(plan, expr, compiled, Processor::LimitOffset, [size, (index.abs - 1) * size])
      end

      def on_project(plan, expr, compiled)
        compiled = plan.recompile(compiled){|p|
          p.clip(expr.operand, expr.stay_attributes)
        }
        preserving = expr.key_preserving? rescue false
        if not(preserving) and not(expr.stay_attributes.empty?)
          compiled = rewrite(plan, expr, compiled, Processor::Distinct)
        end
        rebind(plan, expr, compiled)
      end

      def on_rename(plan, expr, compiled)
        rewrite(plan, expr, compiled, Processor::Rename, [expr.renaming])
      end

      def on_restrict(plan, expr, compiled)
        rewrite(plan, expr, compiled, Processor::Where, [expr.predicate])
      end

      # def on_summarize(plan, expr, compiled)
      #   # -> SQL's GROUP-BY
      # end

      def on_union(plan, expr, left, right)
        rewrite(plan, expr, left, Processor::Merge, [:union, right.sexpr])
      end

    protected

      def builder(plan)
        plan.options(self)
      end

      def cog_class
        Cog
      end

      def fresh_cog(expr, sexpr)
        cog_class.new(expr, self, sexpr)
      end

      def rewrite(plan, expr, compiled, processor, args = [])
        builder  = builder(plan)
        rewrited = processor.new(*args.push(builder)).call(compiled.sexpr)
        cog_class.new(expr, self, rewrited)
      end

      def rebind(plan, expr, compiled)
        cog_class.new(expr, self, compiled.sexpr)
      end

    end # class Compilable
  end # module Sql
end # module Alf
