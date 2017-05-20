source 'https://rubygems.org'

ruby File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip

gem 'rails', '~> 5.1.1'

#gem 'sqlite3'
gem 'pg', '~> 0.20.0'
gem 'sprockets', '~> 3.7.1'
gem 'sprockets-rails', '~> 3.2.0'
gem 'ancestry', '~> 3.0.0'
gem 'friendly_id', '~> 5.2.1'
gem 'redcarpet', '~> 3.4.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 4.2.1'
  gem 'uglifier', '~> 3.2.0'
  gem 'bootstrap', '~> 4.0.0.alpha6'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# Fake values generator
gem 'faker', '~> 1.7.3'
group :development, :test do
  # Pretty printed test output
  gem 'turn', '~> 0.9.6', require: false
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_girl_rails', '~> 4.8.0'
  #gem 'rspec-context-private'
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'listen', '~> 3.1.5'
  # Run tests with clean database
  gem 'database_cleaner', '~> 1.5.3'
  # Very informative error pages with console
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'
  # Generate code coverate reports
  gem 'simplecov', '~> 0.13.0', require: false
end

gem 'rails_12factor', group: :production
gem 'puma'
