module Alf
  module Sql
    module WithExp
      include Expr

      WITH = "WITH".freeze

      def with_exp?
        true
      end

      def with_spec
        self[1]
      end

      def select_exp
        last
      end

      def qualifier_proc
        select_exp.qualifier_proc
      end

    # to_xxx

      def to_attr_list
        last.to_attr_list
      end

      def to_ordering
        last.to_ordering
      end

      def to_sql(buffer = "")
        buffer << WITH << SPACE
        self[1].to_sql(buffer)
        buffer << SPACE
        self[2].to_sql(buffer, false)
        buffer
      end

    end # module WithExp
  end # module Sql
end # module Alf
