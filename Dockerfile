FROM centos:centos7
MAINTAINER yuroyoro

# Install base packages
RUN yum install -y make cmake openssl-devel git wget unzip tar gcc gcc-c++ patch libyaml-devel libffi-devel readline-devel zlib-devel automake libtool bison bzip2
yum clean all
RUN yum clean all

# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git .ruby-build
RUN .ruby-build/install.sh
RUN rm -fr .ruby-build

# build ruby-2.1.2 using ruby-build
RUN ruby-build 2.1.2 /usr/local

# gem install bundler
RUN gem update --system
RUN gem install bundler --no-rdoc --no-ri

# Setup Gitterb
RUN cd /opt; git clone https://github.com/yuroyoro/gitterb
RUN cd /opt/gitterb; bundle install --path=vendor/bundle --binstubs=vendor/bin
RUN cd /opt/gitterb; bundle exec rake assets:precompile
RUN cd /opt; git clone https://github.com/rails/rails
ADD config/initializers/repositories.rb.docker /opt/gitterb/config/initializers/repositories.rb

WORKDIR /opt/gitterb

EXPOSE 3000
ENTRYPOINT ["/opt/gitterb/bin/bundle", "exec", "unicorn_rails", "-c", "/opt/gitterb/config/unicorn.rb", "-p", "3000", "-E", "production"]
