require 'spec_helper'
module Alf
  module Sql
    class Processor
      describe Requalify, "on_select_exp" do

        subject{ Requalify.new(Builder.new(1)).on_select_exp(expr) }

        context 'when not already ordered' do
          let(:expr){
            select_all
          }

          let(:expected){
            select_all_from_t1_as_t2
          }

          it{ should eq(expected) }
        end

      end
    end
  end
end
