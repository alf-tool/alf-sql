require 'alf-core'
require 'alf-sql'
require "rspec"
require "ap"

require_relative '../shared/compiled_examples'

RSpec.configure do |c|
  c.include Alf::Lang::Functional
end
