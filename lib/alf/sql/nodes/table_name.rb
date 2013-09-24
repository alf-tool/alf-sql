module Alf
  module Sql
    module TableName
      include Expr

      def to_sql(buffer = "")
        buffer << last.to_s
        buffer
      end

    end # module TableName
  end # module Sql
end # module Alf
