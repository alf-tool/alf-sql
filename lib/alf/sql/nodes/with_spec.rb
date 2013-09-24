module Alf
  module Sql
    module WithSpec
      include Expr

      def to_sql(buffer = "")
        each_child do |child,index|
          buffer << COMMA << SPACE unless index==0
          child.to_sql(buffer)
        end
        buffer
      end

    end # module WithSpec
  end # module Sql
end # module Alf
