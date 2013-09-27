require 'alf-core'
require 'alf-test'
require 'alf-sql'

require_relative 'support/helpers'

include Helpers

# ensure creation of the parser and compiler
conn.parse("DUM")
compiler

Alf::Test::Sap.each_query do |query|
  next unless query.sqlizable?

  alf_expr, sql_expr = strip(query.alf), strip(query.sql)

  ast, parsing       = measure{ conn.parse(query.alf) }
  sql_ast, compiling = measure{ compiler.call(ast)    }
  to_sql, printing   = measure{ sql_ast.to_sql        }

  puts Alf::Support.to_ruby_literal({
    category: query.category,
    alf: alf_expr,
    sql: sql_expr,
    parsing: parsing,
    compiling: compiling,
    printing: printing,
    total: parsing + compiling + printing
  })
end
