module Alf
  module Sql
    module Processor
      class Rename < SelectListRewriter
        grammar Sql::Grammar

        def initialize(renaming, builder = nil)
          @renaming = renaming
        end

        alias :on_select_list :copy_and_apply

        def on_select_item(sexpr)
          return sexpr unless newname = @renaming[sexpr.as_name.to_sym]
          [:select_item, sexpr[1], [:column_name, newname.to_s]]
        end

      end # class Rename
    end # module Processor
  end # module Sql
end # module Alf
