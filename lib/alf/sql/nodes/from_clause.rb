module Alf
  module Sql
    module FromClause
      include Expr

      FROM = "FROM".freeze

      def table_spec
        last
      end

      def to_sql(buffer = "")
        buffer << FROM << SPACE
        last.to_sql(buffer)
        buffer
      end

    end # module FromClause
  end # module Sql
end # module Alf
