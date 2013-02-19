# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ar-extensions"
  s.version = "0.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Dennis", "Mark Van Holstyn", "Blythe Dunham"]
  s.date = "2009-04-20"
  s.description = "Extends ActiveRecord functionality by adding better finder/query support, as well as supporting mass data import, foreign key, CSV and temporary tables"
  s.email = "zach.dennis@gmail.com"
  s.extra_rdoc_files = ["README"]
  s.files = ["README"]
  s.homepage = "http://www.continuousthinking.com/tags/arext"
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "arext"
  s.rubygems_version = "1.8.16"
  s.summary = "Extends ActiveRecord functionality."

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.1.2"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.1.2"])
  end
end
