# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{grit}
  s.version = "2.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Tom Preston-Werner}, %q{Scott Chacon}]
  s.date = %q{2011-01-13}
  s.description = %q{Grit is a Ruby library for extracting information from a git repository in an object oriented manner.}
  s.email = %q{tom@github.com}
  s.extra_rdoc_files = [%q{README.md}, %q{LICENSE}]
  s.files = [%q{README.md}, %q{LICENSE}]
  s.homepage = %q{http://github.com/mojombo/grit}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{grit}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby Git bindings.}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mime-types>, ["~> 1.15"])
      s.add_runtime_dependency(%q<diff-lcs>, ["~> 1.1"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<mime-types>, ["~> 1.15"])
      s.add_dependency(%q<diff-lcs>, ["~> 1.1"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<mime-types>, ["~> 1.15"])
    s.add_dependency(%q<diff-lcs>, ["~> 1.1"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
