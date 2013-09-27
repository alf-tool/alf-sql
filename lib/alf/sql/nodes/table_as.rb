module Alf
  module Sql
    module TableAs
      include Expr

      def table_name
        self[1].last
      end

      def as_name
        self[2].last
      end

      def to_sql(buffer = "")
        self[1].to_sql(buffer)
        buffer << " AS "
        self[2].to_sql(buffer)
        buffer
      end

    end # module TableAs
  end # module Sql
end # module Alf
