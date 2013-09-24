require 'spec_helper'
module Alf
  module Sql
    describe Processor, "on_with_exp" do

      let(:clazz){
        Class.new(Processor){
          def on_select_exp(sexpr)
            [:foo, :bar, sexpr]
          end
        }
      }

      subject{ clazz.new.on_with_exp(expr) }

      let(:expr){
        Grammar.sexpr [:with_exp, with_spec, select_all_ab]
      }

      let(:expected){
        [:with_exp, with_spec, [:foo, :bar, select_all_ab]]
      }

      it{ should eq(expected) }

    end
  end
end
