require 'alf-core'
require 'alf-test'
require 'alf-sql'
require "rspec"

module Helpers

  def conn
    Alf::Test::Sap.connect(viewpoint: Alf::Test::Sap::Fake)
  end

  def measure
    t1 = Time.now
    res = yield
    t2 = Time.now
    [res, (t2 - t1)]
  end

  def strip(x)
    x.strip.gsub(/\s+/, " ").gsub(/\(\s+/, "(").gsub(/\s+\)/, ")")
  end

  def compiler
    @compiler ||= Alf::Sql::Compiler.new
  end

end

require_relative '../shared/compiled_examples'

RSpec.configure do |c|
  c.include Alf::Lang::Functional
  c.include Helpers
end
