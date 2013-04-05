# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "pingr"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bodacious"]
  s.date = "2013-02-27"
  s.description = "A simple gem for pinging search engines with your XML sitemap"
  s.email = ["bodacious@katanacode.com"]
  s.homepage = "https://github.com/KatanaCode/pingr"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Ping search engines with your XML Sitemap"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
