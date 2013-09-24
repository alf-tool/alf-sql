module Alf
  module Sql
    module WhereClause
      include Expr

      WHERE = "WHERE".freeze

      def to_sql(buffer = "")
        buffer << WHERE << SPACE
        last.to_sql(buffer)
        buffer
      end

    end # module WhereClause
  end # module Sql
end # module Alf
