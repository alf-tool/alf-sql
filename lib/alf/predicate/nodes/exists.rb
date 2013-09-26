module Alf
  class Predicate
    module Exists
      include Expr

      def to_sql(buffer)
        buffer << Sql::Expr::EXISTS
        last.to_sql(buffer)
        buffer
      end

    end
  end
end
