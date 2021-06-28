# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = '0.24.3'

gem "decidim", DECIDIM_VERSION
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-initiatives_no_signature_allowed", path: "."

gem "bootsnap", "~> 1.4"
gem "puma", "< 6"
gem "uglifier", "~> 4.1"

group :development, :test do
  gem 'pry'
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "webdrivers"
end

group :development do
  gem "faker", "~> 2.14"
  gem "letter_opener_web", "~> 1.4"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.7"
end
