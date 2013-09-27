module Alf
  module Sql
    module SelectExp
      include Expr

      SELECT_DISTINCT = "SELECT DISTINCT".freeze

      SELECT = "SELECT".freeze

      def set_quantifier
        self[1]
      end

      def with_exp?
        false
      end

      def distinct?
        set_quantifier.distinct?
      end

      def all?
        set_quantifier.all?
      end

      def join?
        from_clause && from_clause.join?
      end

      def select_exp
        self
      end

      def select_list
        self[2]
      end

      def where_clause
        find_child(:where_clause)
      end

      def predicate
        where_clause && where_clause.predicate
      end

      def from_clause
        find_child(:from_clause)
      end

      def table_spec
        from_clause.table_spec
      end

      def order_by_clause
        find_child(:order_by_clause)
      end

      def limit_clause
        find_child(:limit_clause)
      end

      def offset_clause
        find_child(:offset_clause)
      end

      def desaliaser
        select_list.desaliaser
      end

    ### to_xxx

      def to_attr_list
        select_list.to_attr_list
      end

    ### to_sql

      def to_sql(buffer = "", parenthesize = !buffer.empty?)
        if parenthesize
          sql_parenthesized(buffer){|b| to_sql(b, false) }
        else
          buffer << (distinct? ? SELECT_DISTINCT : SELECT)
          each_child(1) do |elm,i|
            buffer << SPACE
            elm.to_sql(buffer)
          end
          buffer
        end
      end

    end # module SelectExp
  end # module Sql
end # module Alf
