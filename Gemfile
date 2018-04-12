source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'browser', '~> 2.5', '>= 2.5.3'
gem 'cocoon'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.2'
gem 'devise-i18n'
gem 'foundation-rails'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'

gem "paperclip", "~> 5.2.1"
gem 'pg', '~> 0.18.4'
gem 'ransack'
gem 'rails', '~> 5.1.5'

gem "roo", "~> 2.7.0"
gem "roo-xls"

gem 'sass-rails', '~> 5.0'

gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn', '~> 5.1' # HTTP server for Rack applications

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'faker', '~> 1.6', '>= 1.6.6'
end

group :development do
  gem 'database_cleaner', '~> 1.6.1'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

