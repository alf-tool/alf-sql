require 'spec_helper'
module Alf
  module Sql
    describe "SQL compiler -- " do

      def self.install_test_for(query)
        describe "#{query['query']}" do

          let(:expr){ conn.parse(query['query']) }

          subject{
            compiler.call(expr)
          }

          it_should_behave_like "a compiled"

          it 'should have expected SQL' do
            strip(subject.to_sql).should eq(strip(query['sql']))
          end
        end
      end

      def self.install_tests_for(queries)
        queries.each do |query|
          install_test_for(query)
        end
      end

      Alf::Test.each_query_file do |file|
        describe "On #{file.basename}" do
          install_tests_for(file.load)
        end
      end

    end
  end
end
