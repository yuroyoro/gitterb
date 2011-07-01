# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec-expectations}
  s.version = "2.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{David Chelimsky}, %q{Chad Humphries}]
  s.date = %q{2011-05-12}
  s.description = %q{rspec expectations (should[_not] and matchers)}
  s.email = %q{dchelimsky@gmail.com;chad.humphries@gmail.com}
  s.extra_rdoc_files = [%q{README.md}]
  s.files = [%q{README.md}]
  s.homepage = %q{http://github.com/rspec/rspec-expectations}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rspec}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{rspec-expectations-2.6.0}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<diff-lcs>, ["~> 1.1.2"])
    else
      s.add_dependency(%q<diff-lcs>, ["~> 1.1.2"])
    end
  else
    s.add_dependency(%q<diff-lcs>, ["~> 1.1.2"])
  end
end
