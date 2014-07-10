source 'http://rubygems.org'

gem 'rails', '3.2.19'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

# Use unicorn as the web server
gem 'unicorn'

# Asset template engines
gem 'sass-rails'
gem 'coffee-script'
gem 'uglifier'

# Deploy with Capistrano
# gem 'capistrano'
# gem 'capistrano-ext'
# gem 'capistrano_colors'

gem 'execjs'
gem 'therubyracer'

gem 'haml-rails'
gem 'rugged',  git: 'git://github.com/libgit2/rugged.git',  branch: 'development',  submodules: true
gem 'pry-rails'
gem 'awesome_print'
gem 'hirb-unicode'

# To use debugger
case RUBY_VERSION
when '1.8.7'
  gem 'ruby-debug'
  gem 'columnize', '0.3.0'
when '1.9.3'
  gem 'debugger', :require => 'ruby-debug'
  gem 'columnize', '>=0.3.0'
when '2.0.0'
  gem 'byebug'
when '2.1.0', '2.1.1', '2.1.2'
  gem 'byebug'
end

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'
gem 'jquery-rails'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'webrat'
  gem 'rails3-generators'
  gem 'rspec-rails',  '>= 2.0.0'
  gem 'factory_girl'
end
