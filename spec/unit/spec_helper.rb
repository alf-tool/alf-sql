require 'alf-core'
require 'alf-sql'
require "rspec"
require "ap"

require_relative 'helpers/ast'
require_relative 'helpers/compiler'

require_relative '../shared/compiled_examples'

RSpec.configure do |c|
  c.include Alf::Lang::Functional
  c.include Helpers
  c.extend  Helpers
end
