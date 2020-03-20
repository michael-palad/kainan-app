source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'

gem 'jquery-rails', '>= 4.3.1'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.5.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Added Gems
gem 'devise', '~> 4.4', '>= 4.4.2'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'will_paginate', '~> 3.1', '>= 3.1.5'

gem 'faker', '~> 1.6', '>= 1.6.3'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
  gem 'factory_girl_rails', '~> 4.8', '>= 4.8.0'
  gem 'sqlite3'
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
end





