$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "alf/sql/version"
$version = Alf::Sql::Version.to_s

Gem::Specification.new do |s|
  s.name = "alf-sql"
  s.version = $version
  s.summary = "An abstract SQL compiler for Alf expressions"
  s.description = "This project implements an abstract SQL compiler for Alf expressions"
  s.homepage = "http://github.com/blambeau/alf-sql"
  s.authors = ["Bernard Lambeau"]
  s.email  = ["blambeau at gmail.com"]
  s.require_paths = ['lib']
  here = File.expand_path(File.dirname(__FILE__))
  s.files = File.readlines(File.join(here, 'Manifest.txt')).
                 inject([]){|files, pattern| files + Dir[File.join(here, pattern.strip)]}.
                 collect{|x| x[(1+here.size)..-1]}


  s.add_development_dependency("rake", "~> 10.1")
  s.add_development_dependency("rspec", "~> 2.14")
  s.add_dependency("sexpr", "~> 0.6.0")
  s.add_dependency("alf-core", "0.18.0")

end
