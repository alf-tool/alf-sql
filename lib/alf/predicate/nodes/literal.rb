module Alf
  class Predicate
    module Literal

      def to_sql(buffer = "")
        to_sql_literal(buffer, value)
        buffer
      end

    end
  end
end
