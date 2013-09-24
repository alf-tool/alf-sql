require 'spec_helper'
module Alf
  module Sql
    module Processor
      describe SelectListRewriter, "on_dyadic" do

        let(:clazz){
          Class.new(SelectListRewriter){
            def on_select_exp(sexpr)
              [:foo, :bar, sexpr]
            end
          }
        }

        subject{ clazz.new.on_dyadic(expr) }

        let(:expr){
          [:union, all, select_all_a, select_all_b]
        }

        let(:expected){
          [:union, all, [:foo, :bar, select_all_a], [:foo, :bar, select_all_b]]
        }

        it{ should eq(expected) }

      end
    end
  end
end
