module Alf
  module Algebra
    module Operand

      def to_sql
        cog = to_cog
        unless cog.respond_to?(:to_sql)
          raise NotSupportedError, "Unable to compile `#{self}` to SQL"
        end
        cog.to_sql
      end

    end # module Operand
  end # module Algebra
end # module Alf