module Alf
  module Sql
    class Processor
      class Rename < Processor
        grammar Sql::Grammar

        def initialize(renaming, builder = Builder.new)
          super(builder)
          @renaming = renaming
        end

        alias :on_select_list :copy_and_apply

        def on_select_item(sexpr)
          return sexpr unless newname = @renaming[sexpr.as_name.to_sym]
          [:select_item, sexpr[1], [:column_name, newname.to_s]]
        end

      end # class Rename
    end # class Processor
  end # module Sql
end # module Alf
