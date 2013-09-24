module Alf
  module Sql
    module OrderByTerm
      include Expr

      def qualifier
        self[1].qualifier
      end

      def as_name
        self[1].as_name
      end

      def direction
        last
      end

      def to_sql(buffer = "")
        self[1].to_sql(buffer)
        buffer << SPACE << direction.upcase
        buffer
      end

    end # module OrderByTerm
  end # module Sql
end # module Alf
