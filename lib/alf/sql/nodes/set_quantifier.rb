module Alf
  module Sql
    module SetQuantifier
      include Expr

      def all?
        last == "all"
      end

      def distinct?
        last == "distinct"
      end

      def to_sql(buffer = "")
        buffer << self.last
      end

    end # module SetQuantifier
  end # module Sql
end # module Alf
