require 'spec_helper'
module Alf
  module Sql
    class Processor
      describe Clip do

        subject{ Clip.new([:a]).call(expr) }

        context 'on a select_exp' do
          let(:expr){ select_ab }

          it{ should eq(select_a) }
        end

        context 'on a with_exp' do
          let(:expr){ with_exp(nil, select_ab) }

          it{ should eq(with_exp(nil, select_a)) }
        end

      end
    end
  end
end
