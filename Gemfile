source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
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

gem 'rails-i18n', '~> 5.0.0'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-rails'
gem 'rolify'
gem 'pundit'
gem 'rails-ujs'
gem 'carrierwave', '~> 1.0'
# gem 'dropzonejs-rails'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
gem 'sidekiq'
gem 'webpacker', '~> 3.0'
gem 'friendly_id', '~> 5.1.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara'
  gem 'selenium-webdriver', '2.53.4'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'bullet'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use Capistrano for deployment
  # gem 'capistrano', '~> 3.6'
  # gem 'capistrano-rails', '~> 1.3'
  # gem 'capistrano-rvm'
  # gem 'capistrano3-puma', github: "seuros/capistrano-puma"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap', git: 'https://github.com/twbs/bootstrap-rubygem'
gem 'inline_svg'
