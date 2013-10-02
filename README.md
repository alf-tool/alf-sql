# Alf::Sql

[![Build Status](https://secure.travis-ci.org/alf-tool/alf-sql.png)](http://travis-ci.org/alf-tool/alf-sql)
[![Dependency Status](https://gemnasium.com/alf-tool/alf-sql.png)](https://gemnasium.com/alf-tool/alf-sql)

An abstract SQL compiler for Alf expressions

## Links

* http://github.com/alf-tool/alf
* http://github.com/alf-tool/alf-sql
* http://github.com/alf-tool/alf-sequel

## Synopsis

This sub-module provides an abstract SQL compiler for Alf expressions. It is
NOT aimed at being used by end-users (the API illustrated below is considered
private and may change at any time). Instead, it provides a basis for concrete
translators converting the resulting SQL abstract syntax tree to a concrete SQL
dialect through third-party libraries.

See [alf-sequel](https://github.com/alf-tool/alf-sequel) for a translator built
on top of [Sequel](http://sequel.rubyforge.org/).

## Example

```ruby
require 'alf-sql'
require 'alf-test' # this gem comes with the suppliers and parts (Sap) examplar

Alf::Test::Sap.connect(:fake) do |conn|
  # Let parse some relational expression
  expr = conn.parse{
    restrict(suppliers, city: 'London')
  }

  # Translate to SQL
  # (non-portable SQL output unless you require alf-sequel as well)
  puts expr.to_sql
  # => SELECT t1.sid, t1.name, t1.status, t1.city
  #      FROM suppliers AS t1
  #     WHERE t1.city = 'London'

  # Alternatively (for translator implementers),
  # compile to an abstract cog (cannot be iterated)
  cog = Alf::Sql::Compiler.new.call(expr)

  # Let see the SQL AST
  puts cog.to_sexpr.inspect
  # => [ :select_exp, [:select_list, ...] ]
end
```
