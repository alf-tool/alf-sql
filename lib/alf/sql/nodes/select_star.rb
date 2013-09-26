module Alf
  module Sql
    module SelectStar
      include Expr

      STAR = "*".freeze

      def to_sql(buffer = "")
        buffer << SPACE << STAR << SPACE
        buffer
      end

    end # module SelectStar
  end # module Sql
end # module Alf
