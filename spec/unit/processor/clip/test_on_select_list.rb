require 'spec_helper'
module Alf
  module Sql
    class Processor
      describe Clip, "on_select_list" do

        subject{ Clip.new(AttrList[:a]).on_select_list(expr) }

        context 'when included' do
          let(:expr){ select_list_ab }

          it{ should eq(select_list_a) }
        end

        context 'when unique' do
          let(:expr){ select_list_a }

          it{ should eq(select_list_a) }
        end

      end
    end
  end
end
