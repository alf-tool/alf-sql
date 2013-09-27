module Alf
  module Sql
    module SetOperator
      include Expr

      def left
        self[2]
      end

      def right
        self[3]
      end

      def set_quantifier
        self[1]
      end

      def with_exp?
        false
      end

      def set_operator?
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

      def to_sql(buffer = "", parenthesize = !buffer.empty?)
        if parenthesize
          sql_parenthesized(buffer){|b| to_sql(b, false) }
        else
          left.to_sql(buffer, true)
          buffer << SPACE << keyword
          unless distinct?
            buffer << SPACE
            set_quantifier.to_sql(buffer)
          end
          buffer << SPACE
          right.to_sql(buffer, true)
          buffer
        end
      end

    end # module SetOperator
  end # module Sql
end # module Alf
