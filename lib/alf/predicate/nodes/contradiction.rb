module Alf
  class Predicate
    module Contradiction

      def to_sql(buffer)
        buffer << Sql::Expr::FALSE
        buffer
      end

    end
  end
end
