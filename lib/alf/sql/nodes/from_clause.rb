module Alf
  module Sql
    module FromClause
      include Expr

      def to_sql(buffer = "")
        buffer << "FROM "
        sexpr_body.each do |c|
          c.to_sql(buffer)
        end
        buffer
      end

    end # module FromClause
  end # module Sql
end # module Alf
