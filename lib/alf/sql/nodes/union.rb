module Alf
  module Sql
    module Union
      include Nadic

      UNION = "UNION".freeze

      def keyword
        UNION
      end

    end # module Union
  end # module Sql
end # module Alf
