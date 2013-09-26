module Alf
  module Sql
    module Literal
      include Expr
      include Alf::Predicate::Expr

      def would_be_name
        nil
      end

      def to_sql(buffer = "")
        to_sql_literal(buffer, last)
        buffer
      end

    end # module Literal
  end # module Sql
end # module Alf
