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
        let(:expr){
          builder.order_by_clause(ordering){|a|
            [:qualified_name, [:range_var_name, "t1"], [:column_name, a]]
          }
        }

        it{ should eq(ordering) }
      end

    end
  end
end
