module Alf
  module Sql
    module WhereClause
      include Expr

      WHERE = "WHERE".freeze

      def bool_exp
        last
      end

      def to_sql(buffer = "")
        buffer << WHERE << SPACE
        bool_exp.to_sql(buffer)
        buffer
      end

    end # module WhereClause
  end # module Sql
end # module Alf
