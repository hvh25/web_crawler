# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gelf"
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexey Palazhchenko", "Lennart Koopmann"]
  s.date = "2013-01-26"
  s.description = "Library to send GELF messages to Graylog2 logging server. Supports plain-text, GELF messages and exceptions."
  s.email = "alexey.palazhchenko@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/Graylog2/gelf-rb"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Library to send GELF messages to Graylog2 logging server."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
