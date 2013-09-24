module Alf
  class Predicate
    module Literal

      def to_sql(buffer = "")
        to_sql_literal(buffer, value)
        buffer
      end

      def to_sql_literal(buffer, value)
        case value
        when Integer, Float
          buffer << value.to_s
        else
          buffer << Sql::Expr::QUOTE << value.to_s << Sql::Expr::QUOTE
        end
      end

    end
  end
end
