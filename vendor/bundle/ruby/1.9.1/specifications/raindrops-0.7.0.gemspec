# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{raindrops}
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{raindrops hackers}]
  s.date = %q{2011-06-27}
  s.description = %q{Raindrops is a real-time stats toolkit to show statistics for Rack HTTP
servers.  It is designed for preforking servers such as Rainbows! and
Unicorn, but should support any Rack HTTP server under Ruby 1.9, 1.8 and
Rubinius on platforms supporting POSIX shared memory.  It may also be
used as a generic scoreboard for sharing atomic counters across multiple
processes.}
  s.email = %q{raindrops@librelist.org}
  s.extensions = [%q{ext/raindrops/extconf.rb}]
  s.extra_rdoc_files = [%q{README}, %q{LICENSE}, %q{NEWS}, %q{ChangeLog}, %q{lib/raindrops.rb}, %q{lib/raindrops/aggregate.rb}, %q{lib/raindrops/aggregate/last_data_recv.rb}, %q{lib/raindrops/aggregate/pmq.rb}, %q{lib/raindrops/last_data_recv.rb}, %q{lib/raindrops/linux.rb}, %q{lib/raindrops/middleware.rb}, %q{lib/raindrops/middleware/proxy.rb}, %q{lib/raindrops/struct.rb}, %q{lib/raindrops/watcher.rb}, %q{ext/raindrops/raindrops.c}, %q{ext/raindrops/linux_inet_diag.c}, %q{ext/raindrops/linux_tcp_info.c}]
  s.files = [%q{README}, %q{LICENSE}, %q{NEWS}, %q{ChangeLog}, %q{lib/raindrops.rb}, %q{lib/raindrops/aggregate.rb}, %q{lib/raindrops/aggregate/last_data_recv.rb}, %q{lib/raindrops/aggregate/pmq.rb}, %q{lib/raindrops/last_data_recv.rb}, %q{lib/raindrops/linux.rb}, %q{lib/raindrops/middleware.rb}, %q{lib/raindrops/middleware/proxy.rb}, %q{lib/raindrops/struct.rb}, %q{lib/raindrops/watcher.rb}, %q{ext/raindrops/raindrops.c}, %q{ext/raindrops/linux_inet_diag.c}, %q{ext/raindrops/linux_tcp_info.c}, %q{ext/raindrops/extconf.rb}]
  s.homepage = %q{http://raindrops.bogomips.org/}
  s.rdoc_options = [%q{-t}, %q{raindrops - real-time stats for preforking Rack servers}, %q{-W}, %q{http://bogomips.org/raindrops.git/tree/%s}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rainbows}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{real-time stats for preforking Rack servers}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0.10"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0.10"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0.10"])
  end
end
