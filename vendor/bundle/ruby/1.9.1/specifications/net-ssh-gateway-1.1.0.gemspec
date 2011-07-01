# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-ssh-gateway}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jamis Buck}]
  s.date = %q{2011-04-30}
  s.description = %q{A simple library to assist in establishing tunneled Net::SSH connections}
  s.email = %q{net-ssh-gateway@solutious.com}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{lib/net/ssh/gateway.rb}, %q{README.rdoc}]
  s.files = [%q{CHANGELOG.rdoc}, %q{lib/net/ssh/gateway.rb}, %q{README.rdoc}]
  s.homepage = %q{http://net-ssh.rubyforge.org/gateway}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Net-ssh-gateway}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{net-ssh-gateway}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A simple library to assist in establishing tunneled Net::SSH connections}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ssh>, [">= 1.99.1"])
    else
      s.add_dependency(%q<net-ssh>, [">= 1.99.1"])
    end
  else
    s.add_dependency(%q<net-ssh>, [">= 1.99.1"])
  end
end
