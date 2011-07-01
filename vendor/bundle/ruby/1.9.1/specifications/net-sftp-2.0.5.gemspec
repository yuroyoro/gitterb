# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-sftp}
  s.version = "2.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jamis Buck}]
  s.date = %q{2010-08-19}
  s.description = %q{A pure Ruby implementation of the SFTP client protocol}
  s.email = %q{netsftp@solutious.com}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{lib/net/sftp/constants.rb}, %q{lib/net/sftp/errors.rb}, %q{lib/net/sftp/operations/dir.rb}, %q{lib/net/sftp/operations/download.rb}, %q{lib/net/sftp/operations/file.rb}, %q{lib/net/sftp/operations/file_factory.rb}, %q{lib/net/sftp/operations/upload.rb}, %q{lib/net/sftp/packet.rb}, %q{lib/net/sftp/protocol/01/attributes.rb}, %q{lib/net/sftp/protocol/01/base.rb}, %q{lib/net/sftp/protocol/01/name.rb}, %q{lib/net/sftp/protocol/02/base.rb}, %q{lib/net/sftp/protocol/03/base.rb}, %q{lib/net/sftp/protocol/04/attributes.rb}, %q{lib/net/sftp/protocol/04/base.rb}, %q{lib/net/sftp/protocol/04/name.rb}, %q{lib/net/sftp/protocol/05/base.rb}, %q{lib/net/sftp/protocol/06/attributes.rb}, %q{lib/net/sftp/protocol/06/base.rb}, %q{lib/net/sftp/protocol/base.rb}, %q{lib/net/sftp/protocol.rb}, %q{lib/net/sftp/request.rb}, %q{lib/net/sftp/response.rb}, %q{lib/net/sftp/session.rb}, %q{lib/net/sftp/version.rb}, %q{lib/net/sftp.rb}, %q{README.rdoc}]
  s.files = [%q{CHANGELOG.rdoc}, %q{lib/net/sftp/constants.rb}, %q{lib/net/sftp/errors.rb}, %q{lib/net/sftp/operations/dir.rb}, %q{lib/net/sftp/operations/download.rb}, %q{lib/net/sftp/operations/file.rb}, %q{lib/net/sftp/operations/file_factory.rb}, %q{lib/net/sftp/operations/upload.rb}, %q{lib/net/sftp/packet.rb}, %q{lib/net/sftp/protocol/01/attributes.rb}, %q{lib/net/sftp/protocol/01/base.rb}, %q{lib/net/sftp/protocol/01/name.rb}, %q{lib/net/sftp/protocol/02/base.rb}, %q{lib/net/sftp/protocol/03/base.rb}, %q{lib/net/sftp/protocol/04/attributes.rb}, %q{lib/net/sftp/protocol/04/base.rb}, %q{lib/net/sftp/protocol/04/name.rb}, %q{lib/net/sftp/protocol/05/base.rb}, %q{lib/net/sftp/protocol/06/attributes.rb}, %q{lib/net/sftp/protocol/06/base.rb}, %q{lib/net/sftp/protocol/base.rb}, %q{lib/net/sftp/protocol.rb}, %q{lib/net/sftp/request.rb}, %q{lib/net/sftp/response.rb}, %q{lib/net/sftp/session.rb}, %q{lib/net/sftp/version.rb}, %q{lib/net/sftp.rb}, %q{README.rdoc}]
  s.homepage = %q{http://net-ssh.rubyforge.org/sftp}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Net-sftp}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{net-ssh}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A pure Ruby implementation of the SFTP client protocol}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ssh>, [">= 2.0.9"])
    else
      s.add_dependency(%q<net-ssh>, [">= 2.0.9"])
    end
  else
    s.add_dependency(%q<net-ssh>, [">= 2.0.9"])
  end
end
