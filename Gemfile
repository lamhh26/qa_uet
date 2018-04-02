source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootstrap-sass", "~> 3.3.7"
gem "carrierwave"
gem "ckeditor"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "counter_culture", "~> 1.8"
gem "devise"
gem "ffaker"
gem "figaro"
gem "font-awesome-rails"
gem "impressionist"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "kaminari"
gem "mini_magick"
gem "mysql2", "~> 0.4.4"
gem "pnotify-rails"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.2"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "autoprefixer-rails"
  gem "better_errors"
  gem "brakeman", require: false
  gem "bundler-audit"
  gem "database_cleaner"
  gem "guard-rspec", require: false
  gem "jshint"
  gem "pry-byebug"
  gem "pry-rails"
  gem "railroady"
  gem "rails_best_practices"
  gem "reek"
  gem "rspec"
  gem "rspec-collection_matchers"
  gem "rspec-rails"
  gem "rubocop", "~> 0.52.1", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "scss_lint", require: false
  gem "scss_lint_reporter_checkstyle", require: false
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara"
  gem "cucumber-rails", require: false
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov-json"
  gem "simplecov-rcov", require: false
  gem "webmock"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
