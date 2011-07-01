# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{webrat}
  s.version = "0.7.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Bryan Helmkamp}]
  s.date = %q{2011-01-01}
  s.description = %q{Webrat lets you quickly write expressive and robust acceptance tests
for a Ruby web application. It supports simulating a browser inside
a Ruby process to avoid the performance hit and browser dependency of
Selenium or Watir, but the same API can also be used to drive real
Selenium tests when necessary (eg. for testing AJAX interactions).
Most Ruby web frameworks and testing frameworks are supported.}
  s.email = %q{bryan@brynary.com}
  s.extra_rdoc_files = [%q{README.rdoc}, %q{MIT-LICENSE.txt}, %q{History.txt}]
  s.files = [%q{README.rdoc}, %q{MIT-LICENSE.txt}, %q{History.txt}]
  s.homepage = %q{http://github.com/brynary/webrat}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{webrat}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby Acceptance Testing for Web applications}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.2.0"])
      s.add_runtime_dependency(%q<rack>, [">= 1.0"])
      s.add_runtime_dependency(%q<rack-test>, [">= 0.5.3"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.2.0"])
      s.add_dependency(%q<rack>, [">= 1.0"])
      s.add_dependency(%q<rack-test>, [">= 0.5.3"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.2.0"])
    s.add_dependency(%q<rack>, [">= 1.0"])
    s.add_dependency(%q<rack-test>, [">= 0.5.3"])
  end
end
