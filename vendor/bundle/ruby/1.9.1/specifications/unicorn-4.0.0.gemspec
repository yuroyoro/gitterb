# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{unicorn}
  s.version = "4.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Unicorn hackers}]
  s.date = %q{2011-06-27}
  s.description = %q{\Unicorn is an HTTP server for Rack applications designed to only serve
fast clients on low-latency, high-bandwidth connections and take
advantage of features in Unix/Unix-like kernels.  Slow clients should
only be served by placing a reverse proxy capable of fully buffering
both the the request and response in between \Unicorn and slow clients.}
  s.email = %q{mongrel-unicorn@rubyforge.org}
  s.executables = [%q{unicorn}, %q{unicorn_rails}]
  s.extensions = [%q{ext/unicorn_http/extconf.rb}]
  s.extra_rdoc_files = [%q{FAQ}, %q{README}, %q{TUNING}, %q{PHILOSOPHY}, %q{HACKING}, %q{DESIGN}, %q{CONTRIBUTORS}, %q{LICENSE}, %q{SIGNALS}, %q{KNOWN_ISSUES}, %q{TODO}, %q{NEWS}, %q{ChangeLog}, %q{LATEST}, %q{lib/unicorn.rb}, %q{lib/unicorn/app/exec_cgi.rb}, %q{lib/unicorn/app/inetd.rb}, %q{lib/unicorn/app/old_rails.rb}, %q{lib/unicorn/app/old_rails/static.rb}, %q{lib/unicorn/cgi_wrapper.rb}, %q{lib/unicorn/configurator.rb}, %q{lib/unicorn/const.rb}, %q{lib/unicorn/http_request.rb}, %q{lib/unicorn/http_response.rb}, %q{lib/unicorn/http_server.rb}, %q{lib/unicorn/launcher.rb}, %q{lib/unicorn/oob_gc.rb}, %q{lib/unicorn/preread_input.rb}, %q{lib/unicorn/socket_helper.rb}, %q{lib/unicorn/stream_input.rb}, %q{lib/unicorn/tee_input.rb}, %q{lib/unicorn/tmpio.rb}, %q{lib/unicorn/util.rb}, %q{lib/unicorn/worker.rb}, %q{ISSUES}, %q{Sandbox}, %q{Links}]
  s.files = [%q{bin/unicorn}, %q{bin/unicorn_rails}, %q{FAQ}, %q{README}, %q{TUNING}, %q{PHILOSOPHY}, %q{HACKING}, %q{DESIGN}, %q{CONTRIBUTORS}, %q{LICENSE}, %q{SIGNALS}, %q{KNOWN_ISSUES}, %q{TODO}, %q{NEWS}, %q{ChangeLog}, %q{LATEST}, %q{lib/unicorn.rb}, %q{lib/unicorn/app/exec_cgi.rb}, %q{lib/unicorn/app/inetd.rb}, %q{lib/unicorn/app/old_rails.rb}, %q{lib/unicorn/app/old_rails/static.rb}, %q{lib/unicorn/cgi_wrapper.rb}, %q{lib/unicorn/configurator.rb}, %q{lib/unicorn/const.rb}, %q{lib/unicorn/http_request.rb}, %q{lib/unicorn/http_response.rb}, %q{lib/unicorn/http_server.rb}, %q{lib/unicorn/launcher.rb}, %q{lib/unicorn/oob_gc.rb}, %q{lib/unicorn/preread_input.rb}, %q{lib/unicorn/socket_helper.rb}, %q{lib/unicorn/stream_input.rb}, %q{lib/unicorn/tee_input.rb}, %q{lib/unicorn/tmpio.rb}, %q{lib/unicorn/util.rb}, %q{lib/unicorn/worker.rb}, %q{ISSUES}, %q{Sandbox}, %q{Links}, %q{ext/unicorn_http/extconf.rb}]
  s.homepage = %q{http://unicorn.bogomips.org/}
  s.rdoc_options = [%q{-t}, %q{Unicorn: Rack HTTP server for fast clients and Unix}, %q{-W}, %q{http://bogomips.org/unicorn.git/tree/%s}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{mongrel}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Rack HTTP server for fast clients and Unix}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<kgio>, ["~> 2.4"])
      s.add_runtime_dependency(%q<raindrops>, ["~> 0.6"])
      s.add_development_dependency(%q<isolate>, ["~> 3.1"])
      s.add_development_dependency(%q<wrongdoc>, ["~> 1.5"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<kgio>, ["~> 2.4"])
      s.add_dependency(%q<raindrops>, ["~> 0.6"])
      s.add_dependency(%q<isolate>, ["~> 3.1"])
      s.add_dependency(%q<wrongdoc>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<kgio>, ["~> 2.4"])
    s.add_dependency(%q<raindrops>, ["~> 0.6"])
    s.add_dependency(%q<isolate>, ["~> 3.1"])
    s.add_dependency(%q<wrongdoc>, ["~> 1.5"])
  end
end
