# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "blogit"
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bodacious"]
  s.date = "2013-02-27"
  s.description = "Add a blog to your Rails application in minutes with this mountable Rails Engine"
  s.email = ["gavin@gavinmorrice.com"]
  s.homepage = "http://bodacious.github.com/blogit/"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "A mountable Rails blog for Rails 3.1 + applications"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<RedCloth>, [">= 4.2.9"])
      s.add_runtime_dependency(%q<redcarpet>, [">= 2.0.1"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_runtime_dependency(%q<albino>, [">= 1.3.3"])
      s.add_runtime_dependency(%q<acts-as-taggable-on>, [">= 2.2.1"])
      s.add_runtime_dependency(%q<kaminari>, [">= 0.13.0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<pingr>, [">= 0.0.3"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_development_dependency(%q<growl>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, [">= 4.1.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<rb-inotify>, [">= 0.8.8"])
    else
      s.add_dependency(%q<RedCloth>, [">= 4.2.9"])
      s.add_dependency(%q<redcarpet>, [">= 2.0.1"])
      s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_dependency(%q<albino>, [">= 1.3.3"])
      s.add_dependency(%q<acts-as-taggable-on>, [">= 2.2.1"])
      s.add_dependency(%q<kaminari>, [">= 0.13.0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<pingr>, [">= 0.0.3"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<growl>, [">= 0"])
      s.add_dependency(%q<factory_girl>, [">= 4.1.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<rb-inotify>, [">= 0.8.8"])
    end
  else
    s.add_dependency(%q<RedCloth>, [">= 4.2.9"])
    s.add_dependency(%q<redcarpet>, [">= 2.0.1"])
    s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
    s.add_dependency(%q<albino>, [">= 1.3.3"])
    s.add_dependency(%q<acts-as-taggable-on>, [">= 2.2.1"])
    s.add_dependency(%q<kaminari>, [">= 0.13.0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<pingr>, [">= 0.0.3"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<growl>, [">= 0"])
    s.add_dependency(%q<factory_girl>, [">= 4.1.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<rb-inotify>, [">= 0.8.8"])
  end
end
