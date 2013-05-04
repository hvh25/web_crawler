# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ancestry"
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stefan Kroes"]
  s.date = "2012-05-03"
  s.description = "Organise ActiveRecord model into a tree structure"
  s.email = "s.a.kroes@gmail.com"
  s.homepage = "http://github.com/stefankroes/ancestry"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Ancestry allows the records of a ActiveRecord model to be organised in a tree structure, using a single, intuitively formatted database column. It exposes all the standard tree structure relations (ancestors, parent, root, children, siblings, descendants) and all of them can be fetched in a single sql query. Additional features are named_scopes, integrity checking, integrity restoration, arrangement of (sub)tree into hashes and different strategies for dealing with orphaned records."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3.14"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.3.14"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.3.14"])
  end
end
