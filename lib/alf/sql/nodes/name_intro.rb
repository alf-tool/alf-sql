module Alf
  module Sql
    module NameIntro
      include Expr

      def table_name
        self[1]
      end

      def subquery
        self[2]
      end

      def to_sql(buffer = "")
        table_name.to_sql(buffer)
        buffer << SPACE << AS << SPACE
        subquery.to_sql(buffer, true)
        buffer
      end

    end # module WithSpec
  end # module Sql
end # module Alf
