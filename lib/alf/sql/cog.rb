module Alf
  module Sql
    class Cog
      include Alf::Compiler::Cog

      def initialize(expr, compiler, sexpr)
        super(expr, compiler)
        @sexpr = sexpr
      end
      attr_reader :sexpr
      alias :to_sexpr :sexpr

      def flatten
        Cog.new(expr, compiler, sexpr.flatten)
      end

      def cog_orders
        [ sexpr.ordering ].compact
      end

      def should_be_reused?
        sexpr.should_be_reused?
      end

      def to_sql(buffer = "")
        sexpr.to_sql(buffer)
      end

      def each(&bl)
        raise NotSupportedError,\
          "This is an abstract SQL compilation result. Please use alf-sequel."
      end

    end # module Cog
  end # module Sql
end # module Alf
