module Alf
  module Sql
    module RangeVarName
      include Expr

      def qualifier
        last
      end

      def to_sql(buffer = "")
        buffer << last
        buffer
      end

    end # module RangeVarName
  end # module Sql
end # module Alf
