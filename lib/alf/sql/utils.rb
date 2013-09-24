module Alf
  module Sql
    module Utils

      DISTINCT = Grammar.sexpr([:set_quantifier, "distinct"]).freeze
           ALL = Grammar.sexpr([:set_quantifier, "all"]).freeze

      def distinct
        DISTINCT
      end

      def all
        ALL
      end
      alias :not_distinct :all

    end # module Utils
  end # module Sql
end # module Alf
