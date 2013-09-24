module Alf
  module Sql
    module Processor
      class SelectListRewriter < MainSelectRewriter

        def on_dyadic(sexpr)
          sexpr[0..1] + sexpr[2..-1].map{|x| apply(x) }
        end
        alias :on_union     :on_dyadic
        alias :on_except    :on_dyadic
        alias :on_intersect :on_dyadic

        def on_select_exp(sexpr)
          sexpr[0..1] + [ apply(sexpr[2]) ] + sexpr[3..-1]
        end

      end # module MainSelectRewriter
    end # module Processor
  end # module Sql
end # module Alf
