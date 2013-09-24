module Alf
  class Predicate
    module DyadicComp

      def to_sql(buffer = "")
        left.to_sql(buffer)
        buffer << Sql::Expr::SPACE << to_sql_operator << Sql::Expr::SPACE
        right.to_sql(buffer)
        buffer
      end

    end
  end
end
