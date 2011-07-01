# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{highline}
  s.version = "1.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{James Edward Gray II}]
  s.date = %q{2011-05-13}
  s.description = %q{A high-level IO library that provides validation, type conversion, and more for
command-line interfaces. HighLine also includes a complete menu system that can
crank out anything from simple list selection to complete shells with just
minutes of work.
}
  s.email = %q{james@grayproductions.net}
  s.extra_rdoc_files = [%q{README}, %q{INSTALL}, %q{TODO}, %q{CHANGELOG}, %q{LICENSE}]
  s.files = [%q{README}, %q{INSTALL}, %q{TODO}, %q{CHANGELOG}, %q{LICENSE}]
  s.homepage = %q{http://highline.rubyforge.org}
  s.rdoc_options = [%q{--title}, %q{HighLine Documentation}, %q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{highline}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{HighLine is a high-level command-line IO library.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
