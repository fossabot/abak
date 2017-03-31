source 'http://rubygems.org'

gem 'rails', '3.1.0.rc8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'strong_parameters'
gem 'ancestry'
gem 'jquery-rails'

source 'https://rails-assets.org' do

	gem 'rails-assets-tether', '>= 1.3.3'
	
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do

	gem 'sass-rails', "  ~> 3.1.0.rc"
	gem 'coffee-rails', "~> 3.1.0.rc"
	gem 'uglifier'
	gem 'bootstrap', '~> 4.0.0.alpha6'
	gem 'bootstrap-sass', '~> 3.1.0'

end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do

	# Pretty printed test output
	gem 'turn', :require => false

end

group :development, :test do

	gem 'rspec-rails', '~> 3.5'
	gem 'factory_girl_rails'

end