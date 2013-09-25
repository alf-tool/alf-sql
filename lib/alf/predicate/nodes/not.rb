module Alf
  class Predicate
    module Not

      def to_sql(buffer)
        buffer << Sql::Expr::NOT << Sql::Expr::LEFT_PARENTHESE
        last.to_sql(buffer)
        buffer << Sql::Expr::RIGHT_PARENTHESE
        buffer
      end

    end
  end
end
