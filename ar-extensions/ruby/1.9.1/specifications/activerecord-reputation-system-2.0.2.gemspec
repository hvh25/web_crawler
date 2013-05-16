# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "activerecord-reputation-system"
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Katsuya Noguchi"]
  s.date = "2012-12-01"
  s.description = "ActiveRecord Reputation System gem allows rails apps to compute and publish reputation scores for active record models."
  s.email = ["katsuya@twitter.com"]
  s.homepage = "https://github.com/twitter/activerecord-reputation-system"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "ActiveRecord Reputation System gem allows rails apps to compute and publish reputation scores for active record models"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0.8.7"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, ["~> 0.7.1"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3.5"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0.8.7"])
      s.add_dependency(%q<rspec>, ["~> 2.8"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, ["~> 0.7.1"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3.5"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0.8.7"])
    s.add_dependency(%q<rspec>, ["~> 2.8"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, ["~> 0.7.1"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3.5"])
  end
end
