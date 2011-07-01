# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{archive-tar-minitar}
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Austin Ziegler, Mauricio Ferna'ndez}]
  s.date = %q{2008-02-26}
  s.description = %q{Archive::Tar::Minitar is a pure-Ruby library and command-line utility that provides the ability to deal with POSIX tar(1) archive files. The implementation is based heavily on Mauricio Ferna'ndez's implementation in rpa-base, but has been reorganised to promote reuse in other projects.}
  s.email = %q{minitar@halostatue.ca}
  s.executables = [%q{minitar}]
  s.extra_rdoc_files = [%q{README}, %q{ChangeLog}, %q{Install}]
  s.files = [%q{bin/minitar}, %q{README}, %q{ChangeLog}, %q{Install}]
  s.homepage = %q{http://rubyforge.org/projects/ruwiki/}
  s.rdoc_options = [%q{--title}, %q{Archive::Tar::MiniTar -- A POSIX tarchive library}, %q{--main}, %q{README}, %q{--line-numbers}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubyforge_project = %q{ruwiki}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Provides POSIX tarchive management from Ruby programs.}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
