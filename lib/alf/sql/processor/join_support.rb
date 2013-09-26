module Alf
  module Sql
    class Processor
      module JoinSupport

        def on_main_exp(sexpr)
          joined = apply_join_strategy(sexpr.select_exp, right.select_exp)
          merge_with_exps(sexpr, right, joined)
        end
        alias :on_with_exp   :on_main_exp
        alias :on_select_exp :on_main_exp

      private

        def merge_with_exps(left, right, joined)
          if left.with_exp? and right.with_exp?
            [:with_exp,
              left.with_spec + right.with_spec.sexpr_body,
              joined ]
          elsif left.with_exp?
            left.with_update(-1, joined)
          elsif right.with_exp?
            right.with_update(-1, joined)
          else
            joined
          end
        end

        def join_predicate(left, right, commons = left.to_attr_list & right.to_attr_list)
          commons = left.to_attr_list & right.to_attr_list
          left_d, right_d = left.desaliaser, right.desaliaser
          commons.to_a.inject(tautology){|cond, attr|
            left_attr, right_attr = left_d[attr], right_d[attr]
            cond &= Predicate::Factory.eq(left_attr, right_attr)
          }
        end

      end # class JoinSupport
    end # class Processor
  end # module Sql
end # module Alf
