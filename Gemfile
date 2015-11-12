source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

########## START Added Gems ##############
# bootstrap nice web look
gem "bootstrap-sass"
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# handling for permission
gem 'cancancan', '~> 1.10'
gem "rails-erd"

###### START WYSIWYG editor & related gems ######
gem "ckeditor"
# gem "paperclip"
gem 'carrierwave'
gem 'mini_magick'
# RMagick is an interface between Ruby and ImageMagick
# gem 'rmagick', '~> 2.15', '>= 2.15.2'
###### END WYSIWYG editor & related gems ######
########## END Added Gems ##############

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  ########## START Added Gems ##############
  # we use the three gems below for a nicer Rails console display
  gem "awesome_print"
  gem "interactive_editor"
  gem "hirb"
  ########## END Added Gems ##############
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
