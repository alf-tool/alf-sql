module Alf
  class Predicate
    module Identifier

      def to_sql(buffer = "")
        buffer << name.to_s
        buffer
      end

    end
  end
end
