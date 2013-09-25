require 'alf-core'
require 'alf-sql'
require "rspec"
require "ap"

require_relative '../shared/compiled_examples'
require_relative 'support/viewpoint'
require_relative 'support/helpers'

RSpec.configure do |c|
  c.include Alf::Lang::Functional
  c.include Helpers
end
