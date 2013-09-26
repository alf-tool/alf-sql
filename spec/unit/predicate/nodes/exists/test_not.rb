require 'spec_helper'
module Alf
  class Predicate
    describe Exists, "!" do

      let(:expr){
        Grammar.sexpr [:exists, :foo]
      }

      let(:expected){
        Grammar.sexpr [:not, [:exists, :foo]]
      }

      subject{ !expr }

      it{ should eq(expected) }

    end
  end
end
