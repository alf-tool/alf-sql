module Alf
  module Sql
    module Processor
      class MainSelectRewriter < Sexpr::Rewriter
        include Sql::Utils
        grammar Sql::Grammar

        def on_with_exp(sexpr)
          sexpr[0..1] << apply(sexpr.last)
        end

      end # module MainSelectRewriter
    end # module Processor
  end # module Sql
end # module Alf
