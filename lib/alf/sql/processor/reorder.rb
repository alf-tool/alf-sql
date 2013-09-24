module Alf
  module Sql
    class Processor
      class Reorder < Processor
        grammar Sql::Grammar

        def initialize(attr_list, builder = Builder.new)
          super(builder)
          @indexes = Hash[attr_list.to_a.map(&:to_s).each_with_index.to_a]
        end

        def on_select_list(sexpr)
          reordered = sexpr.sexpr_body.sort{|i1,i2|
            @indexes[i1.as_name] <=> @indexes[i2.as_name]
          }
          reordered.unshift(:select_list)
        end

      end # class Reorder
    end # class Processor
  end # module Sql
end # module Alf
