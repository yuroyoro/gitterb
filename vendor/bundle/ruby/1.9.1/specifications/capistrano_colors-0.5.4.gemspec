# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{capistrano_colors}
  s.version = "0.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Mathias Stjernstrom}]
  s.date = %q{2011-03-17}
  s.description = %q{Simple gem to display colors in capistrano output.}
  s.email = %q{mathias@globalinn.com}
  s.extra_rdoc_files = [%q{README.rdoc}, %q{lib/capistrano_colors.rb}, %q{lib/capistrano_colors/configuration.rb}, %q{lib/capistrano_colors/logger.rb}]
  s.files = [%q{README.rdoc}, %q{lib/capistrano_colors.rb}, %q{lib/capistrano_colors/configuration.rb}, %q{lib/capistrano_colors/logger.rb}]
  s.homepage = %q{http://github.com/stjernstrom/capistrano_colors}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Capistrano_colors}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{capistranocolor}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Simple gem to display colors in capistrano output.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<capistrano>, [">= 2.3.0"])
    else
      s.add_dependency(%q<capistrano>, [">= 2.3.0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 2.3.0"])
  end
end
