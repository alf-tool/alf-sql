module Helpers
  module Compiler

    def an_operand(cog = nil)
      Alf::Algebra::Operand::Fake.new(nil, cog)
    end

    def compiler
      @compiler ||= Alf::Sql::Compiler.new
    end

    def builder(start = 0)
      @builder ||= Alf::Sql::Builder.new(start)
    end

    def suppliers
      @suppliers ||= an_operand.with_name(:suppliers)
                               .with_heading(sid: String, name: String, status: Integer, city: String)
    end

  end
  include Compiler
end
