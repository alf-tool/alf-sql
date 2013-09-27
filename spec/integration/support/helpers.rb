module Helpers

  def conn
    Alf.connect(Path.dir, viewpoint: Alf::Test::Sap::Fake)
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
