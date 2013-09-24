module Alf
  module Sql
    module Processor
      class Clip < SelectListRewriter
        grammar Sql::Grammar

        def initialize(attributes, builder = nil)
          super()
          @attributes = attributes
        end

        def on_select_list(sexpr)
          items = sexpr.sexpr_body.select{|item|
            @attributes.include?(item.as_name.to_sym)
          }
          items.unshift(:select_list)
        end

      end # class Clip
    end # module Processor
  end # module Sql
end # module Alf
