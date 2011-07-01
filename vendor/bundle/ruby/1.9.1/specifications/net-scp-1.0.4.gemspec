# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-scp}
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jamis Buck}, %q{Delano Mandelbaum}]
  s.date = %q{2010-08-17}
  s.description = %q{A pure Ruby implementation of the SCP client protocol}
  s.email = %q{net-scp@solutious.com}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{lib/net/scp/download.rb}, %q{lib/net/scp/errors.rb}, %q{lib/net/scp/upload.rb}, %q{lib/net/scp/version.rb}, %q{lib/net/scp.rb}, %q{lib/uri/open-scp.rb}, %q{lib/uri/scp.rb}, %q{README.rdoc}]
  s.files = [%q{CHANGELOG.rdoc}, %q{lib/net/scp/download.rb}, %q{lib/net/scp/errors.rb}, %q{lib/net/scp/upload.rb}, %q{lib/net/scp/version.rb}, %q{lib/net/scp.rb}, %q{lib/uri/open-scp.rb}, %q{lib/uri/scp.rb}, %q{README.rdoc}]
  s.homepage = %q{http://net-ssh.rubyforge.org/scp}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Net-scp}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{net-ssh}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A pure Ruby implementation of the SCP client protocol}

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
