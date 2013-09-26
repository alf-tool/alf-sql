module Alf
  module Sql
    class Processor
      class Star < Processor
        grammar Sql::Grammar

        def on_select_exp(sexpr)
          sexpr.with_update(:select_list, builder.select_star)
        end

      end # class Star
    end # class Processor
  end # module Sql
end # module Alf
