# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec}
  s.version = "2.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Steven Baker}, %q{David Chelimsky}]
  s.date = %q{2011-05-12}
  s.description = %q{BDD for Ruby}
  s.email = %q{rspec-users@rubyforge.org;}
  s.extra_rdoc_files = [%q{README.markdown}]
  s.files = [%q{README.markdown}]
  s.homepage = %q{http://github.com/rspec}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rspec}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{rspec-2.6.0}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec-core>, ["~> 2.6.0"])
      s.add_runtime_dependency(%q<rspec-expectations>, ["~> 2.6.0"])
      s.add_runtime_dependency(%q<rspec-mocks>, ["~> 2.6.0"])
    else
      s.add_dependency(%q<rspec-core>, ["~> 2.6.0"])
      s.add_dependency(%q<rspec-expectations>, ["~> 2.6.0"])
      s.add_dependency(%q<rspec-mocks>, ["~> 2.6.0"])
    end
  else
    s.add_dependency(%q<rspec-core>, ["~> 2.6.0"])
    s.add_dependency(%q<rspec-expectations>, ["~> 2.6.0"])
    s.add_dependency(%q<rspec-mocks>, ["~> 2.6.0"])
  end
end
