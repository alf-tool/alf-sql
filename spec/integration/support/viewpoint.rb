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
