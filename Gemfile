source 'http://rubygems.org'

gem 'rails', '3.0.3'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'pg', :group => :production

# gem 'haml', '>= 3.0.12'
gem 'haml-rails', '=0.3.4'
gem 'compass', '>= 0.10.4'
gem 'jsmin'
gem 'warden'
gem 'net-ldap', '>= 0.1.1'
gem 'omniauth', '>= 0.1.6'
gem 'delayed_job', '~> 2.1.2'


group :production, :test, :cucumber, :development do
  gem 'tarte',      :path => '~/Sites/tools/tarte'
  gem 'formidable', :path => '~/Sites/tools/formidable'
  gem 'tabelle',    :path => '~/Sites/tools/tabelle'
  gem 'aws-s3'
  gem 'paperclip'
  gem 'cancan'
end

group :production, :test, :cucumber, :development do
  gem 'connie', :path => '~/Sites/tools/connie'
  gem 'factory_girl_rails', '>= 1.0.0'
  gem 'factory_girl_generator'
end


group :test, :cucumber do
  gem 'capybara', '>= 0.3.8'
  gem 'capybara-envjs'
  gem 'cucumber-rails', '>= 0.3.2'
  gem 'pickle', '>= 0.3.4'
  gem 'database_cleaner', '>= 0.5.2'
  gem 'timecop', '~> 0.3.5'
  gem 'launchy', '>= 0.3.5'
  gem 'rspec-rails', '>= 2.1.0'
  gem 'fredo'
  gem 'ruby-debug'
  # gem 'spork', '>= 0.8.4'
end

group :development do
  gem 'wirble'
  gem 'awesome_print'
  # gem 'slowgrowl'
end