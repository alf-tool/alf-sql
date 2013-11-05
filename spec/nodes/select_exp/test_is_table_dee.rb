require 'spec_helper'
module Alf
  module Sql
    describe SelectExp, "is_table_dee?" do

      subject{ expr.is_table_dee? }

      context 'when normal select' do
        let(:expr){ select_all }

        it{ should be_false }
      end

      context 'when a select is table dee' do
        let(:expr){ select_is_table_dee }

        it{ should be_true }
      end

    end
  end
end
