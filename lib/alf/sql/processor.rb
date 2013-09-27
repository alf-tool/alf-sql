module Alf
  module Sql
    class Processor < Sexpr::Rewriter
      grammar Sql::Grammar

      def initialize(builder = Builder.new)
        @builder = builder
      end
      attr_reader :builder

      def on_with_exp(sexpr)
        sexpr.with_update(-1, apply(sexpr.select_exp))
      end

      def on_set_operator(sexpr)
        sexpr.each_with_index.map{|child,index|
          index <= 1 ? child : apply(child)
        }
      end
      alias :on_union     :on_set_operator
      alias :on_except    :on_set_operator
      alias :on_intersect :on_set_operator

      def on_select_exp(sexpr)
        sexpr.with_update(2, apply(sexpr[2]))
      end

    private

      def tautology
        Predicate::Factory.tautology
      end

    end
  end
end
require_relative 'processor/distinct'
require_relative 'processor/all'
require_relative 'processor/clip'
require_relative 'processor/star'
require_relative 'processor/rename'
require_relative 'processor/order_by'
require_relative 'processor/limit_offset'
require_relative 'processor/from_self'
require_relative 'processor/reorder'
require_relative 'processor/merge'
require_relative 'processor/where'
require_relative 'processor/join_support'
require_relative 'processor/join'
require_relative 'processor/semi_join'
