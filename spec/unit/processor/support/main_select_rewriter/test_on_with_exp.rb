require 'spec_helper'
module Alf
  module Sql
    module Processor
      describe MainSelectRewriter, "on_with_exp" do

        class MainSelectRewriterTest < MainSelectRewriter

          def on_select_exp(sexpr)
            [:foo, :bar, sexpr]
          end

        end

        subject{ MainSelectRewriterTest.new.on_with_exp(expr) }

        let(:expr){
          [:with_exp, with_spec, select_all_ab]
        }

        let(:expected){
          [:with_exp, with_spec, [:foo, :bar, select_all_ab]]
        }

        it{ should eq(expected) }

      end
    end
  end
end
