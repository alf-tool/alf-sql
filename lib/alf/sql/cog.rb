module Alf
  module Sql
    class Cog
      include Alf::Compiler::Cog

      def initialize(expr, compiler, sexpr)
        raise ArgumentError unless Expr===sexpr
        super(expr, compiler)
        @sexpr = sexpr
      end
      attr_reader :sexpr

      def cog_orders
        [ sexpr.ordering ].compact
      end

      def to_sql(buffer = "")
        sexpr.to_sql(buffer)
      end

    end # module Cog
  end # module Sql
end # module Alf
