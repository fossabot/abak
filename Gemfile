source 'https://rubygems.org'

ruby File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip

gem 'rails'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'pg'
gem 'sprockets'
gem 'sprockets-rails'
gem 'ancestry'
gem 'jquery-rails'
gem 'friendly_id'
gem 'redcarpet'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'bootstrap', '~> 4.0.0.alpha6'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  # Pretty printed test output
  gem 'turn', require: false
  gem 'shoulda-matchers'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rspec-context-private'
  gem 'rails-controller-testing'
  gem 'listen'
end

gem 'rails_12factor', group: :production
gem 'puma'
