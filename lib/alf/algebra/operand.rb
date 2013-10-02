module Alf
  module Algebra
    module Operand

      def to_sql
        cog = to_cog
        if cog.respond_to?(:to_sql)
          cog.to_sql
        else
          Alf::Sql::Compiler.new.call(self).to_sql
        end
      rescue NotSupportedError => ex
        raise NotSupportedError, "Unable to compile `#{self}` to SQL"
      end

    end # module Operand
  end # module Algebra
end # module Alf