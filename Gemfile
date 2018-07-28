source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'carrierwave', '~> 1.0'
gem 'countries'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-rails'
gem 'mini_magick'
gem 'money-rails', '~>1'
gem 'pundit'
gem 'rails-i18n', '~> 5.0.0'
gem 'rails-ujs'
# Use Redis adapter to run Action Cable in production
gem 'dotenv-rails'
gem 'friendly_id', '~> 5.1.0'
gem 'redis'
gem 'sidekiq'
gem 'webpacker', github: 'rails/webpacker'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'brakeman'
  gem 'bullet'
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'letter_opener'
  gem 'pry'
  gem 'rspec-rails', '~> 3.5'
  gem 'selenium-webdriver'
end

group :test do
  gem 'capybara-selenium'
end

group :development do
  gem 'annotate'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-yarn'
  # Add this if you're using rbenv
  # gem 'capistrano-rbenv', '~> 2.1'
  # Add this if you're using rvm
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'bootstrap', git: 'https://github.com/twbs/bootstrap-rubygem'
gem 'inline_svg'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
