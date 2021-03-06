module Alf
  module Sql
    class Processor
      class SemiJoin < Processor
        include JoinSupport

        def initialize(right, negate = false, builder)
          super(builder)
          @right  = right
          @negate = negate
        end
        attr_reader :right, :negate

        def call(sexpr)
          if sexpr.set_operator?
            call(builder.from_self(sexpr))
          elsif right.set_operator?
            SemiJoin.new(builder.from_self(right), negate, builder).call(sexpr)
          else
            super(sexpr)
          end
        end

      private

        def apply_join_strategy(left, right)
          predicate = build_semijoin_predicate(left, right)
          expand_where_clause(left, negate ? !predicate : predicate)
        end

        def build_semijoin_predicate(left, right)
          if right.is_table_dee?
            right.where_clause.predicate
          else
            commons  = left.to_attr_list & right.to_attr_list
            subquery = Clip.new(commons, :star, builder).call(right)
            if commons.size == 0
              builder.exists(subquery)
            elsif commons.size == 1
              identifier = left.desaliaser[commons.to_a.first]
              Predicate::Factory.in(identifier, subquery)
            else
              join_pre  = join_predicate(left, subquery, commons)
              subquery  = expand_where_clause(subquery, join_pre)
              builder.exists(subquery)
            end
          end
        end

        def expand_where_clause(sexpr, predicate)
          Grammar.sexpr \
            [ :select_exp,
              sexpr.set_quantifier,
              sexpr.select_list,
              sexpr.from_clause,
              [ :where_clause, (sexpr.predicate || tautology) & predicate ],
              sexpr.order_by_clause,
              sexpr.limit_clause,
              sexpr.offset_clause ].compact
        end

      end # class SemiJoin
    end # class Processor
  end # module Sql
end # module Alf
