module Alf
  module Sql
    module InnerJoin
      include Expr

      INNER = "INNER".freeze
      JOIN  = "JOIN".freeze
      ON    = "ON".freeze

      def left
        self[1]
      end

      def right
        self[2]
      end

      def predicate
        last
      end

      def to_sql(buffer = "")
        left.to_sql(buffer)
        buffer << SPACE << JOIN << SPACE
        right.to_sql(buffer)
        buffer << SPACE << ON << SPACE
        predicate.to_sql(buffer)
        buffer
      end

    end # module InnerJoin
  end # module Sql
end # module Alf
