module Alf
  module Sql
    module SubqueryAs
      include Expr

      def left
        self[1]
      end
      alias :subquery :left

      def right
        self[2]
      end

      def as_name
        self[2].last
      end

      def to_sql(buffer = "")
        left.to_sql(buffer)
        buffer << " AS "
        right.to_sql(buffer)
        buffer
      end

    end # module SubqueryAs
  end # module Sql
end # module Alf
