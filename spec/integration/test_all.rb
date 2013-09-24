require 'spec_helper'
module Alf
  module Sql
    describe "SQL compiler -- " do

      module TestViewpoint
        include Alf::Viewpoint

        def an_operand
          Alf::Algebra::Operand::Fake.new
        end

        def suppliers(h = {sid: String, name: String, status: Integer, city: String})
          an_operand.with_name(:suppliers)
                    .with_heading(h)
                    .with_keys([:sid], [:name])
        end

        def suppliers_2
          suppliers(name: String, sid: String, city: String, status: Integer)
        end

      end # module Viewpoint

      def conn
        Alf.connect(Path.dir, viewpoint: TestViewpoint)
      end

      def strip(x)
        x.strip.gsub(/\s+/, " ").gsub(/\(\s+/, "(").gsub(/\s+\)/, ")")
      end

      def self.install_test_for(query)
        describe "#{query['query']}" do

          let(:expr){ conn.parse(query['query']) }

          let(:compiler){ Compiler.new }

          subject{ compiler.call(expr) }

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

      Path.dir.glob("*.yml").each do |file|
        describe "On #{file.basename}" do
          install_tests_for(file.load)
        end
      end

    end
  end
end
