require 'spec_helper'
module Alf
  module Sql
    describe Builder, "order_by_clause" do

      let(:ordering){ Ordering.new([[:name, :asc], [:city, :desc]]) }

      context 'without qualifier' do
        subject{ builder.order_by_clause(ordering) }

        let(:expected){
          [:order_by_clause,
            [:order_by_term, [:column_name, 'name'], 'asc'],
            [:order_by_term, [:column_name, 'city'], 'desc'] ]
        }

        it{ should eq(expected) }
      end

      context 'with a qualifier' do
        let(:quantifiers){ {'name' => "t1"} }

        subject{ builder.order_by_clause(ordering){|a| quantifiers[a] } }

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
