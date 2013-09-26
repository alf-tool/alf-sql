module Alf
  module Sql
    module Nadic
      include Expr

      def set_quantifier
        self[1]
      end

      def with_exp?
        false
      end

      def nadic?
        true
      end

      def distinct?
        set_quantifier.distinct?
      end

      def all?
        set_quantifier.all?
      end

      def order_by_clause
        nil
      end

      def to_attr_list
        self.last.to_attr_list
      end

      def to_sql(buffer, parenthesize = !buffer.empty?)
        if parenthesize
          sql_parenthesized(buffer){|b| to_sql(b, false) }
        else
          between = "" << SPACE << keyword
          between << SPACE << self[1] unless all?
          between << SPACE
          each_child(1) do |child, index|
            buffer << between unless index==1
            child.to_sql(buffer, true)
          end
          buffer
        end
      end

    end # module Nadic
  end # module Sql
end # module Alf
