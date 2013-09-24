module Alf
  module Sql
    module ColumnName
      include Expr

      def qualifier
        nil
      end

      def as_name
        last
      end

      def would_be_name
        last
      end

      def to_sql(buffer = "")
        buffer << last
        buffer
      end

    end # module ColumnName
  end # module Sql
end # module Alf
