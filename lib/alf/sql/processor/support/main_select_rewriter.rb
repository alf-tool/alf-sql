module Alf
  module Sql
    module Processor
      class MainSelectRewriter < Sexpr::Rewriter
        grammar Sql::Grammar

        def on_with_exp(sexpr)
          [ :with_exp,
            sexpr.with_spec,
            apply(sexpr.select_exp) ]
        end

      end # module MainSelectRewriter
    end # module Processor
  end # module Sql
end # module Alf
