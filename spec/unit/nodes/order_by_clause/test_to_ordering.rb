require 'spec_helper'
module Alf
  module Sql
    describe OrderByClause, "to_ordering" do

      subject{ expr.to_ordering }

      let(:ordering){
        Ordering.new([[:a, :asc], [:b, :desc]])
      }

      context 'when not qualified' do
        let(:expr){ builder.order_by_clause(ordering) }

        it{ should eq(ordering) }
      end

      context 'when qualified' do
        let(:expr){ builder.order_by_clause(ordering){|a| "t1"} }

        it{ should eq(ordering) }
      end

    end
  end
end
