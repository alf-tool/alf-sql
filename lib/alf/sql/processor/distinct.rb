module Alf
  module Sql
    module Processor
      class Distinct < MainSelectRewriter
        grammar Sql::Grammar

        def initialize(builder = Builder.new)
          @builder = builder
        end
        attr_reader :builder

        def on_set_quantified(sexpr)
          [sexpr.first, builder.distinct] + sexpr[2..-1]
        end
        alias :on_union      :on_set_quantified
        alias :on_except     :on_set_quantified
        alias :on_intersect  :on_set_quantified
        alias :on_select_exp :on_set_quantified

      end # class Distinct
    end # module Processor
  end # module Sql
end # module Alf
