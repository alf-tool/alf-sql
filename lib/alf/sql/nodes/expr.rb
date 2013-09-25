module Alf
  module Sql
    module Expr

      LEFT_PARENTHESE  = "(".freeze
      RIGHT_PARENTHESE = ")".freeze
      SPACE            = " ".freeze
      COMMA            = ",".freeze
      DOT              = ".".freeze
      QUOTE            = "'".freeze
      AS               = "AS".freeze
      AND              = "AND".freeze
      OR               = "OR".freeze
      NOT              = "NOT".freeze
      TRUE             = "TRUE".freeze
      FALSE            = "FALSE".freeze
      EQUAL            = "=".freeze
      NOT_EQUAL        = "<>".freeze
      GREATER          = ">".freeze
      LESS             = "<".freeze
      GREATER_OR_EQUAL = ">=".freeze
      LESS_OR_EQUAL    = "<=".freeze
      IN               = "IN".freeze

      def clip(attributes)
        Processor::Clip.new(attributes).call(self)
      end

      def rename(renaming)
        Processor::Rename.new(renaming).call(self)
      end

      def distinct
        Processor::Distinct.call(self)
      end

      def limit_or_offset?
        not(limit_clause.nil? and offset_clause.nil?)
      end

      def ordering
        obc = order_by_clause
        obc && order_by_clause.to_ordering
      end

    private

      def find_child(kind)
        find{|x| x.is_a?(Array) && x.first == kind }
      end

      def each_child(skip = 0)
        each_with_index do |c,i|
          next if i <= skip
          yield(c, i - 1)
        end
      end

      def sql_parenthesized(buffer)
        buffer << LEFT_PARENTHESE
        yield(buffer)
        buffer << RIGHT_PARENTHESE
      end

    end # module Expr
  end # module Sql
end # module Alf
