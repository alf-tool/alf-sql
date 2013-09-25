module Alf
  class Predicate
    module Native

      def to_sql(buffer = "")
        raise NotSupportedError, "Unable to compile native predicates to SQL"
      end

    end
  end
end
