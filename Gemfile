source 'http://rubygems.org'

gem 'rails', '3.0.5'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'pg', :group => :production

gem "will_paginate", "~> 3.0.pre2"
gem "recaptcha", :require => "recaptcha/rails"

gem 'gdocs4ruby'

gem 'geo_ip', '~> 0.3.0'

gem 'activemerchant'

gem 'subdomain-fu', :git => "git://github.com/nhowell/subdomain-fu.git"
gem "rails3_acts_as_paranoid", :path =>  'vendor/plugins/rails3_acts_as_paranoid'
gem 'kaminari'


# gem 'haml', '>= 3.0.12'
gem 'haml-rails', '=0.3.4'
gem 'compass', '>= 0.10.4'
gem 'jsmin', '=1.0.0'
gem 'warden'

gem 'fastercsv'
gem 'vpim'

# gem 'mongoid',  '2.0.0.rc.7'
gem 'bson_ext', '~> 1.2'
gem 'net-ldap', '>= 0.1.1'
gem 'omniauth', '>= 0.1.6'
gem 'delayed_job', '~> 2.1.2'

gem 'rails3-jquery-autocomplete'
gem 'nifty-generators'


group :production, :test, :cucumber, :development do
  gem 'tarte',      :path => 'vendor/plugins/tarte'
  gem 'formidable', :path => 'vendor/plugins/formidable'
  gem 'tabelle',    :path => 'vendor/plugins/tabelle'
  gem 'aws-s3'
  gem 'paperclip'

  gem 'cancan'
end

group :production, :test, :cucumber, :development do
  gem 'connie', '>= 0.1.0'
  gem 'factory_girl_rails', '>= 1.0.0'
  gem 'factory_girl_generator'
end


group :test, :cucumber do
  gem 'rack-test', :git => "https://github.com/hassox/rack-test.git"
  gem 'capybara', '= 0.4.1.2'
  gem 'capybara-envjs', '= 0.4.0'
  gem 'cucumber-rails', '= 0.4.0 '
  gem 'pickle', '>= 0.3.4'
  gem 'database_cleaner', '>= 0.5.2'
  gem 'timecop', '~> 0.3.5'
  gem 'launchy', '>= 0.3.5'
  gem 'rspec-rails', '>= 2.5.0'
  gem 'fredo', :path => 'vendor/plugins/fredo'
  gem 'ruby-debug'
  # gem 'spork', '>= 0.8.4'
end

group :development do
  gem 'wirble'
  gem 'awesome_print'
  gem 'ruby-debug'
  # gem 'slowgrowl'
end
