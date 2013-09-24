require 'spec_helper'
module Alf
  module Sql
    module Processor
      describe Rename, "on_select_list" do

        subject{ Rename.new(Renaming[a: :b, c: :d]).on_select_list(expr) }

        let(:expr){
          select_list("a" => "a", "x" => "c", "y" => "z")
        }

        let(:expected){
          select_list("a" => "b", "x" => "d", "y" => "z")
        }

        it{ should eq(expected) }

      end
    end
  end
end
