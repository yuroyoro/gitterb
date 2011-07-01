# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby_core_source}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Mark Moseley}]
  s.date = %q{2011-04-02}
  s.description = %q{Retrieve Ruby core source files}
  s.email = %q{mark@fast-software.com}
  s.extra_rdoc_files = [%q{LICENSE}, %q{README}, %q{lib/ruby_core_source.rb}]
  s.files = [%q{LICENSE}, %q{README}, %q{lib/ruby_core_source.rb}]
  s.homepage = %q{http://github.com/mark-moseley/ruby_core_source}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Retrieve Ruby core source files}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<archive-tar-minitar>, [">= 0.5.2"])
    else
      s.add_dependency(%q<archive-tar-minitar>, [">= 0.5.2"])
    end
  else
    s.add_dependency(%q<archive-tar-minitar>, [">= 0.5.2"])
  end
end
