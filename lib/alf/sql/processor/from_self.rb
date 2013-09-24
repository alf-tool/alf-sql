module Alf
  module Sql
    module Processor
      class FromSelf < Sexpr::Rewriter
        grammar Sql::Grammar

        def initialize(builder = Builder.new)
          @builder = builder
        end
        attr_reader :builder

        def on_with_exp(sexpr)
          q = builder.next_qualifier!
          name_intro = builder.name_intro(q, sexpr.select_exp)
          [ :with_exp,
            sexpr.with_spec.dup.push(name_intro),
            builder.select_all(sexpr.select_exp, q, q) ]
        end

        def on_nonjoin_exp(sexpr)
          q = builder.next_qualifier!
          [ :with_exp,
            [:with_spec,
              builder.name_intro(q, sexpr)],
            builder.select_all(sexpr, q, q) ]
        end
        alias :on_union      :on_nonjoin_exp
        alias :on_except     :on_nonjoin_exp
        alias :on_intersect  :on_nonjoin_exp
        alias :on_select_exp :on_nonjoin_exp

      end # class FromSelf
    end # module Processor
  end # module Sql
end # module Alf
