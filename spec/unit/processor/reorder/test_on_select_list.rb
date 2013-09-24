require 'spec_helper'
module Alf
  module Sql
    module Processor
      describe Reorder, "on_select_list" do

        subject{ Reorder.new([:b, :a]).on_select_list(expr) }

        let(:expr){
          select_list_ab
        }

        let(:expected){
          select_list_ba
        }

        it{ should eq(expected) }

      end
    end
  end
end
