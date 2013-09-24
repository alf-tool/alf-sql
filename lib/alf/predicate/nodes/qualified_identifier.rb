module Alf
  class Predicate
    module QualifiedIdentifier

      def to_sql(buffer = "")
        buffer << qualifier.to_s << Sql::Expr::DOT << name.to_s
        buffer
      end

    end
  end
end
