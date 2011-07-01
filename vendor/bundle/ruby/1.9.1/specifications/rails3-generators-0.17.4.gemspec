# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails3-generators}
  s.version = "0.17.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jose Valim}, %q{Anuj Dutta}, %q{Paul Berry}, %q{Jeff Tucker}, %q{Louis T.}, %q{Jai-Gouk Kim}, %q{Darcy Laycock}, %q{Peter Haza}, %q{Peter Gumeson}, %q{Kristian Mandrup}, %q{Alejandro Juarez}]
  s.date = %q{2011-02-02}
  s.description = %q{Rails 3 compatible generators for gems that don't have them yet }
  s.email = %q{andre@arko.net}
  s.extra_rdoc_files = [%q{README.rdoc}, %q{CHANGELOG.rdoc}]
  s.files = [%q{README.rdoc}, %q{CHANGELOG.rdoc}]
  s.homepage = %q{https://github.com/indirect/rails3-generators}
  s.post_install_message = %q{
rails3-generators-0.17.4

Be sure to check out the wiki, https://wiki.github.com/indirect/rails3-generators/,
for information about recent changes to this project.

Machinist generators have been removed. Please update your project to use Machinist 2 (https://github.com/notahat/machinist) which contains its own generators.

Fabrication generators have been removed. Please update your project to use Fabrication (https://github.com/paulelliott/fabrication) which contains its own generators.

Mongoid generators have been removed. Please update your project to use Mongoid (https://github.com/mongoid/mongoid) which contains its own generators.
}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rails3-generators}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Rails 3 compatible generators}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.0.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<haml-rails>, [">= 0"])
      s.add_development_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<factory_girl>, [">= 0"])
    else
      s.add_dependency(%q<railties>, [">= 3.0.0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<haml-rails>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<factory_girl>, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.0.0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<haml-rails>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<factory_girl>, [">= 0"])
  end
end
