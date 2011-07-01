# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kgio}
  s.version = "2.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{kgio hackers}]
  s.date = %q{2011-06-20}
  s.description = %q{kgio provides non-blocking I/O methods for Ruby without raising
exceptions on EAGAIN and EINPROGRESS.  It is intended for use with the
Unicorn and Rainbows! Rack servers, but may be used by other
applications (that run on Unix-like platforms).}
  s.email = %q{kgio@librelist.org}
  s.extensions = [%q{ext/kgio/extconf.rb}]
  s.extra_rdoc_files = [%q{LICENSE}, %q{README}, %q{TODO}, %q{NEWS}, %q{LATEST}, %q{ChangeLog}, %q{ISSUES}, %q{HACKING}, %q{lib/kgio.rb}, %q{ext/kgio/accept.c}, %q{ext/kgio/autopush.c}, %q{ext/kgio/connect.c}, %q{ext/kgio/kgio_ext.c}, %q{ext/kgio/poll.c}, %q{ext/kgio/read_write.c}, %q{ext/kgio/wait.c}, %q{ext/kgio/tryopen.c}]
  s.files = [%q{LICENSE}, %q{README}, %q{TODO}, %q{NEWS}, %q{LATEST}, %q{ChangeLog}, %q{ISSUES}, %q{HACKING}, %q{lib/kgio.rb}, %q{ext/kgio/accept.c}, %q{ext/kgio/autopush.c}, %q{ext/kgio/connect.c}, %q{ext/kgio/kgio_ext.c}, %q{ext/kgio/poll.c}, %q{ext/kgio/read_write.c}, %q{ext/kgio/wait.c}, %q{ext/kgio/tryopen.c}, %q{ext/kgio/extconf.rb}]
  s.homepage = %q{http://bogomips.org/kgio/}
  s.rdoc_options = [%q{-t}, %q{kgio - kinder, gentler I/O for Ruby}, %q{-W}, %q{http://bogomips.org/kgio.git/tree/%s}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rainbows}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{kinder, gentler I/O for Ruby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<wrongdoc>, ["~> 1.5"])
      s.add_development_dependency(%q<strace_me>, ["~> 1.0"])
    else
      s.add_dependency(%q<wrongdoc>, ["~> 1.5"])
      s.add_dependency(%q<strace_me>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<wrongdoc>, ["~> 1.5"])
    s.add_dependency(%q<strace_me>, ["~> 1.0"])
  end
end
