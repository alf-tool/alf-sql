module Alf
  module Sql
    module Except
      include Nadic

      EXCEPT = "EXCEPT".freeze

      def keyword
        EXCEPT
      end

    end # module Except
  end # module Sql
end # module Alf
