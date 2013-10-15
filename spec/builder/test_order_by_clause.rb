require 'spec_helper'
module Alf
  module Sql
    describe Builder, "order_by_clause" do

      let(:ordering){ Ordering.new([[:name, :asc], [:city, :desc]]) }

      context 'without desaliaser' do
        subject{ builder.order_by_clause(ordering) }

        let(:expected){
          [:order_by_clause,
            [:order_by_term, [:column_name, 'name'], 'asc'],
            [:order_by_term, [:column_name, 'city'], 'desc'] ]
        }

        it{ should eq(expected) }
      end

      context 'with a desaliaser' do
        let(:desaliaser){
          ->(a){
            if a == "name"
              [:qualified_name, [:range_var_name, "t1"], [:column_name, a]]
            else
              nil
            end
          }
        }

        subject{ builder.order_by_clause(ordering, &desaliaser) }

        let(:expected){
          [:order_by_clause,
            [:order_by_term, [:qualified_name, [:range_var_name, "t1"], [:column_name, 'name']], 'asc'],
            [:order_by_term, [:column_name, 'city'], 'desc'] ]
        }

        it{ should eq(expected) }
      end

    end
  end
end
