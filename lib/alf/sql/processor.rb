module Alf
  module Sql
    class Processor < Sexpr::Rewriter
      grammar Sql::Grammar

      def initialize(builder = Builder.new)
        @builder = builder
      end
      attr_reader :builder

      def on_with_exp(sexpr)
        [ :with_exp,
          sexpr.with_spec,
          apply(sexpr.select_exp) ]
      end

      def on_nadic(sexpr)
        sexpr[0..1] + sexpr[2..-1].map{|x| apply(x) }
      end
      alias :on_union     :on_nadic
      alias :on_except    :on_nadic
      alias :on_intersect :on_nadic

      def on_select_exp(sexpr)
        sexpr[0..1] + [ apply(sexpr[2]) ] + sexpr[3..-1]
      end

    end
  end
end
require_relative 'processor/distinct'
require_relative 'processor/clip'
require_relative 'processor/rename'
require_relative 'processor/order_by'
require_relative 'processor/limit_offset'
require_relative 'processor/from_self'
require_relative 'processor/reorder'
require_relative 'processor/merge'
