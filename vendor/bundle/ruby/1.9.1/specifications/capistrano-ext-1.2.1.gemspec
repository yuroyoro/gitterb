# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{capistrano-ext}
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jamis Buck}]
  s.date = %q{2008-06-14}
  s.description = %q{Useful task libraries and methods for Capistrano}
  s.email = %q{jamis@jamisbuck.org}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{lib/capistrano/ext/assets/request-counter.rb}, %q{lib/capistrano/ext/monitor.rb}, %q{lib/capistrano/ext/multistage.rb}, %q{lib/capistrano/ext/version.rb}, %q{README}]
  s.files = [%q{CHANGELOG.rdoc}, %q{lib/capistrano/ext/assets/request-counter.rb}, %q{lib/capistrano/ext/monitor.rb}, %q{lib/capistrano/ext/multistage.rb}, %q{lib/capistrano/ext/version.rb}, %q{README}]
  s.homepage = %q{http://www.capify.org}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Capistrano-ext}, %q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{capistrano-ext}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Useful task libraries and methods for Capistrano}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 1.0.0"])
    else
      s.add_dependency(%q<capistrano>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 1.0.0"])
  end
end
