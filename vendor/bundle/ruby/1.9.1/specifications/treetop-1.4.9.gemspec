# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{treetop}
  s.version = "1.4.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Nathan Sobo}]
  s.autorequire = %q{treetop}
  s.date = %q{2010-11-15}
  s.email = %q{nathansobo@gmail.com}
  s.executables = [%q{tt}]
  s.files = [%q{bin/tt}]
  s.homepage = %q{http://functionalform.blogspot.com}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A Ruby-based text parsing and interpretation DSL}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<polyglot>, [">= 0.3.1"])
    else
      s.add_dependency(%q<polyglot>, [">= 0.3.1"])
    end
  else
    s.add_dependency(%q<polyglot>, [">= 0.3.1"])
  end
end
