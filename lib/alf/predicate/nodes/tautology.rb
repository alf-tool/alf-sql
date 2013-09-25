module Alf
  class Predicate
    module Tautology

      def to_sql(buffer)
        buffer << Sql::Expr::TRUE
        buffer
      end

    end
  end
end
