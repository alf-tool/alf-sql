module Alf
  module Sql
    module OrderByClause
      include Expr

      ORDER_BY = "ORDER BY".freeze

      def to_ordering
        @ordering ||= Ordering.new(sexpr_body.map{|x|
          [x.as_name, x.direction]
        })
      end

      def to_sql(buffer = "")
        buffer << ORDER_BY << SPACE
        each_child do |item,index|
          buffer << COMMA << SPACE unless index == 0
          item.to_sql(buffer)
        end
        buffer
      end

    end # module OrderByClause
  end # module Sql
end # module Alf
