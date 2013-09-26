module Alf
  module Sql
    class Builder

      def initialize(start = 0)
        @next_qualifier = (start || 0)
      end

      def distinct
        Grammar.sexpr [:set_quantifier, "distinct"]
      end

      def all
        Grammar.sexpr [:set_quantifier, "all"]
      end
      alias :not_distinct :all

      def name_intro(name, sexpr)
        Grammar.sexpr \
          [:name_intro, table_name(name), sexpr]
      end

      def select_all(heading, name, qualifier = next_qualifier!)
        Grammar.sexpr \
          [ :select_exp, all,
            select_list(heading, qualifier),
            from_clause(name, qualifier) ]
      end

      def select_is_table_dee(subquery)
        Grammar.sexpr \
          [ :select_exp, all, is_table_dee,
            [:where_clause, exists(subquery)] ]
      end

      def is_table_dee
        Grammar.sexpr \
          [:select_list,
            [:select_item,
              [:literal, true],
              [:column_name, "is_table_dee"] ] ]
      end

      def select_list(heading, qualifier)
        unless heading.respond_to?(:to_attr_list)
          raise "Unable to find attribute list on `#{heading.inspect}`"
        end
        attrs = heading.to_attr_list.to_a
        attrs.map{|a| select_item(qualifier, a) }.unshift(:select_list)
      end

      def select_item(qualifier, name, as = name)
        [:select_item,
          qualified_name(qualifier, name.to_s),
          column_name(as.to_s)]
      end

      def select_star
        Grammar.sexpr [:select_star]
      end

      def from_clause(table_name, qualifier)
        [:from_clause,
          table_as(table_name, qualifier) ]
      end

      def table_as(table, qualifier)
        table = case table
                when String, Symbol then table_name(table)
                else table
                end
        [:table_as,
          table,
          range_var_name(qualifier) ]
      end

      def qualified_name(qualifier, name)
        [:qualified_name,
          range_var_name(qualifier),
          column_name(name) ]
      end

      def range_var_name(qualifier)
        [:range_var_name, qualifier]
      end

      def column_name(name)
        [:column_name, name]
      end

      def table_name(name)
        [:table_name, name]
      end

      def exists(subquery)
        Predicate::Grammar.sexpr [ :exists, subquery ]
      end

      def order_by_clause(ordering, &desaliaser)
        Grammar.sexpr \
          ordering.to_a.map{|(s,d)|
            if s.composite?
              raise NotSupportedError, "SQL order by does not support composite selectors"
            end
            name = s.outcoerce.to_s
            name = (desaliaser && desaliaser[name]) || column_name(name)
            [:order_by_term, name, d.to_s]
          }.unshift(:order_by_clause)
      end

      def limit_clause(limit)
        Grammar.sexpr [:limit_clause, limit]
      end

      def offset_clause(limit)
        Grammar.sexpr [:offset_clause, limit]
      end

      def from_self(sexpr)
        Processor::FromSelf.new(self).call(sexpr)
      end

    public

      def next_qualifier!
        "t#{@next_qualifier += 1}"
      end

    end
  end
end
