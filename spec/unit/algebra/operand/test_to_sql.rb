require 'spec_helper'
module Alf
  module Algebra
    describe Operand, "to_sql" do

      subject{ op.to_sql }

      context 'when to_cog does not support to_sql' do
        let(:op) { restrict(suppliers, city: 'London') }

        before do
          op.to_cog.should_not respond_to(:to_sql)
        end

        it{ should eq("SELECT t1.sid, t1.name, t1.status, t1.city FROM suppliers AS t1 WHERE t1.city = 'London'") }
      end

      context 'when to_cog does support to_sql' do
        let(:op) { restrict(suppliers, city: 'London') }

        before do
          def op.to_sql
            :foo
          end
        end

        it{ should eq(:foo) }
      end

    end
  end
end
