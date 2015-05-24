source 'https://rubygems.org'

ruby '2.2.1'
gem 'rails', '4.2.1'

group :development, :test do
  gem 'sqlite3'
end
group :production do
  gem 'pg'
end
gem "rmagick", '~> 2.15.0'
gem "prizm", '~> 0.0.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 5.0.3'
  gem 'coffee-rails', '~> 4.1.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 2.7.1'
end

gem 'jquery-rails'
gem 'rails_12factor', group: :production