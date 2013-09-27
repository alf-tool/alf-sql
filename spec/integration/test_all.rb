require 'spec_helper'
module Alf
  module Sql
    Alf::Test::Sap.each_query do |query|
      next unless query.sqlizable?

      describe "SQL compilation of #{query}" do
        let(:expr){ conn.parse(query.alf) }

        subject{
          compiler.call(expr)
        }

        it_should_behave_like "a compiled"

        it 'should have expected SQL' do
          strip(subject.to_sql).should eq(strip(query.sql))
        end

        it 'should be flattenable' do
          sexpr = subject.sexpr
          flattened = Processor::Flatten.new(Builder.new).call(sexpr)
          if sexpr.first == :with_exp
            flattened.first.should eq(sexpr.select_exp.first)
          else
            flattened.should eq(sexpr)
          end
        end
      end
    end
  end
end
