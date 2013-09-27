require 'alf-core'
require 'alf-test'
require 'alf-sql'

require_relative 'support/helpers'

include Helpers

def measure
  t1 = Time.now
  res = yield
  t2 = Time.now
  [res, (t2 - t1)]
end

Alf::Test.each_query_file do |file|
  basename = file.basename.to_s
  queries  = file.load

  # ensure creation of the parser and compiler
  conn.parse("DUM")
  compiler

  queries.each do |query|
    next unless query['sql']
    alf_expr, sql_expr = strip(query['query']), strip(query['sql'])

    ast, parsing       = measure{ conn.parse(query['query']) }
    sql_ast, compiling = measure{ compiler.call(ast) }
    to_sql, printing   = measure{ sql_ast.to_sql("") }

    puts Alf::Support.to_ruby_literal({
      file: basename,
      query: alf_expr,
      got: sql_expr,
      parsing: parsing,
      compiling: compiling,
      printing: printing,
      total: parsing + compiling + printing
    })
  end
end