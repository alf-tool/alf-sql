module Alf
  module Sql
    class Processor
      class Where < Processor
        grammar Sql::Grammar

        def initialize(predicate, builder = Builder.new)
          super(builder)
          @predicate = predicate
        end

        def on_select_exp(sexpr)
          if sexpr.where_clause
            raise NotSupportedError
          else
            wc = [ :where_clause, 
                   @predicate.qualify(sexpr.qualifier_proc).sexpr ]
            sexpr.dup.insert(4, Grammar.sexpr(wc))
          end
        end

      end # class Where
    end # class Processor
  end # module Sql
end # module Alf
