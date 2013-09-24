module Alf
  module Sql
    module Processor
      class Merge < Sexpr::Rewriter
        grammar Sql::Grammar

        def initialize(kind, right, builder = nil)
          @kind    = kind
          @right   = right
          @builder = builder
        end

        def on_with_exp(sexpr)
          if @right.with_exp?
            reordered = Reorder.new(sexpr.to_attr_list).call(@right)
            [ :with_exp,
              sexpr.with_spec + reordered.with_spec.sexpr_body,
              [ @kind, @builder.all, sexpr.select_exp, reordered.select_exp ] ]
          else
            [ :with_exp,
              sexpr.with_spec,
              apply(sexpr.last) ]
          end
        end

        def on_nonjoin_exp(sexpr)
          reordered = Reorder.new(sexpr.to_attr_list).call(@right)
          if @right.with_exp?
            [ :with_exp,
              reordered.with_spec,
              [ @kind, @builder.all, sexpr, reordered.select_exp ] ]
          else
            [ @kind, @builder.all, sexpr, reordered ]
          end
        end
        alias :on_union      :on_nonjoin_exp
        alias :on_except     :on_nonjoin_exp
        alias :on_intersect  :on_nonjoin_exp
        alias :on_select_exp :on_nonjoin_exp

      end # class Merge
    end # module Processor
  end # module Sql
end # module Alf
