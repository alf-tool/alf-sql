shared_examples_for "a compiled" do

  it{ should be_a(Alf::Sql::Cog) }

  it 'has correct traceability' do
    subject.expr.should be(expr)
  end

  it 'has correct compiler' do
    subject.compiler.should be(compiler)
  end

end