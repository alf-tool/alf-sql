module Alf
  module Sql
    module NameIntro
      include Expr

      def to_sql(buffer = "")
        self[1].to_sql(buffer)
        buffer << SPACE << AS << SPACE
        self[2].to_sql(buffer, true)
        buffer
      end

    end # module WithSpec
  end # module Sql
end # module Alf
