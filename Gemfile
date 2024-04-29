source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "rails", "~> 7.0.4"
gem "pg"
gem "puma"
gem "sass-rails"
gem "webpacker"
gem "turbolinks"
gem "jbuilder"

gem "bootsnap", require: false

gem "bcrypt"
gem "rails-i18n"
gem "kaminari"
gem "date_validator"
gem "valid_email2"
gem "nokogiri"
gem "racc"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "rspec-rails"
  gem "factory_bot_rails"
end
