module Alf
  module Sql
    class Processor
      class Merge < Processor

        def initialize(kind, right, builder)
          super(builder)
          @kind = kind
          @right = right
        end

        def on_with_exp(sexpr)
          if @right.with_exp?
            reordered = Reorder.new(sexpr.to_attr_list, builder).call(@right)
            [ :with_exp,
              sexpr.with_spec + reordered.with_spec.sexpr_body,
              [ @kind, builder.distinct, sexpr.select_exp, reordered.select_exp ] ]
          else
            [ :with_exp,
              sexpr.with_spec,
              apply(sexpr.last) ]
          end
        end

        def on_nonjoin_exp(sexpr)
          reordered = Reorder.new(sexpr.to_attr_list, builder).call(@right)
          if @right.with_exp?
            [ :with_exp,
              reordered.with_spec,
              [ @kind, builder.distinct, sexpr, reordered.select_exp ] ]
          else
            [ @kind, builder.distinct, sexpr, reordered ]
          end
        end
        alias :on_union      :on_nonjoin_exp
        alias :on_except     :on_nonjoin_exp
        alias :on_intersect  :on_nonjoin_exp
        alias :on_select_exp :on_nonjoin_exp

      end # class Merge
    end # class Processor
  end # module Sql
end # module Alf
