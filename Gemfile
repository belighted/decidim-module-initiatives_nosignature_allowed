# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", git: "https://github.com/decidim/decidim", branch: "release/0.22-stable"
gem "decidim-initiatives", git: "https://github.com/decidim/decidim", branch: "release/0.22-stable"
gem "decidim-initiatives_no_signature_allowed", path: "."

gem "puma", ">= 4.3.3"
gem "uglifier", "~> 4.1"

gem "bootsnap"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", git: "https://github.com/decidim/decidim", branch: "release/0.22-stable"
end

group :development do
  gem "faker", "~> 1.9"
  gem "letter_opener_web", "~> 1.4"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.7"
end
