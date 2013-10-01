# Alf::Sql

[![Build Status](https://secure.travis-ci.org/alf-tool/alf-sql.png)](http://travis-ci.org/blambeau/alf-sql)
[![Dependency Status](https://gemnasium.com/alf-tool/alf-sql.png)](https://gemnasium.com/blambeau/alf-sql)

An abstract SQL compiler for Alf expressions

## Links

http://github.com/blambeau/alf-sql
http://github.com/blambeau/alf

## Synopsis

This sub-module provides an abstract SQL compiler for Alf expressions. It is
aimed at being used with a concrete translator for converting the resulting
SQL abstract syntax tree to a concrete SQL dialect.

See [alf-sequel](https://github.com/alf-tool/alf-sequel) for a translator built
on top of [Sequel](http://sequel.rubyforge.org/).

## Example:

```ruby
require 'alf-sql'
require 'alf-test' # this gem comes with the suppliers and parts (Sap) examplar

Alf::Test::Sap.connect(:fake) do |conn|
  expr = conn.parse{ restrict(suppliers, city: 'London') }

  # Compile to an abstract cog
  cog = Alf::Sql::Compiler.new.call(expr)

  # Let see the SQL AST
  puts cog.sexpr.inspect
  # => [ :select_exp, [:select_list, ...] ]

  # Translate to SQL (non-portable SQL output, see alf-sequel instead)
  puts cog.to_sql
  # => SELECT t1.sid, t1.name, t1.status, t1.city
  #      FROM suppliers AS t1
  #     WHERE t1.city = 'London'
end
```
