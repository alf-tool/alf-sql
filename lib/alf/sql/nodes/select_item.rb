module Alf
  module Sql
    module SelectItem
      include Expr

      def qualifier
        self[1].qualifier
      end

      def would_be_name
        self[1].would_be_name
      end

      def as_name
        last.as_name
      end

      def to_sql(buffer = "")
        self[1].to_sql(buffer)
        unless would_be_name == as_name
          buffer << SPACE << AS << SPACE
          last.to_sql(buffer)
        end
        buffer
      end

    end # module SelectItem
  end # module Sql
end # module Alf
