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

  def supplies
    an_operand.with_name(:supplies)
              .with_heading(sid: String, pid: String, qty: Integer)
              .with_keys([:sid, :pid])
  end

  def parts
    an_operand.with_name(:parts)
              .with_heading(pid: String, name: String, color: String, weight: Float, city: String)
              .with_keys([:pid])
  end

end # module Viewpoint
