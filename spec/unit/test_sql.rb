require 'spec_helper'
module Alf
  describe Sql do

    it "should have a version number" do
      Sql.const_defined?(:VERSION).should be_true
    end

  end
end