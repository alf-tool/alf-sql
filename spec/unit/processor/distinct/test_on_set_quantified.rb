require 'spec_helper'
module Alf
  module Sql
    class Processor
      describe Distinct, "on_set_quantified" do

        subject{ Distinct.new.on_set_quantified(expr) }

        let(:expected){
          [:x, distinct]
        }

        context 'when already distinct' do
          let(:expr){
            [:x, distinct]
          }

          it{ should eq(expected) }
        end

        context 'when not distinct' do
          let(:expr){
            [:x, not_distinct]
          }

          it{ should eq(expected) }
        end
      end
    end
  end
end
