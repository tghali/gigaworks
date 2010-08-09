source 'http://rubygems.org'

gem 'rails', '3.0.0.rc'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem "pg", :group => :production

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri', '1.4.1'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'
gem "haml", ">= 3.0.12"


# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :test, :cucumber do
  gem "capybara", ">= 0.3.8"
  gem "cucumber-rails", ">= 0.3.2"
  gem "database_cleaner", ">= 0.5.2"
  gem "factory_girl_rails", ">= 1.0.0"
  gem "launchy", ">= 0.3.5"
  gem "rspec-rails", ">= 2.0.0.beta.12"
  gem "fredo"
  # gem "spork", ">= 0.8.4"
end