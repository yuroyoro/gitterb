# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{polyglot}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Clifford Heath}]
  s.date = %q{2010-03-28}
  s.description = %q{Allows custom language loaders for specified file extensions to be hooked into require}
  s.email = %q{cjheath@rubyforge.org}
  s.extra_rdoc_files = [%q{History.txt}, %q{License.txt}, %q{Manifest.txt}, %q{README.txt}]
  s.files = [%q{History.txt}, %q{License.txt}, %q{Manifest.txt}, %q{README.txt}]
  s.homepage = %q{http://polyglot.rubyforge.org}
  s.rdoc_options = [%q{--main}, %q{README.txt}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{polyglot}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Allows custom language loaders for specified file extensions to be hooked into require}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
