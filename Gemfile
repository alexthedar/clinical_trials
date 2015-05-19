source("https://rubygems.org")

gem 'icalendar', '~> 2.3.0'
gem("sinatra")
gem("sinatra-contrib", :require => "sinatra/reloader")
gem("sinatra-activerecord")
gem("rake")
gem("pg")
gem("pry")
gem("shoulda-matchers")


group(:test) do
  gem("rspec")
  gem("pry")
  gem("shoulda-matchers")
end

group(:production) do
  gem("sinatra")
  gem("pry")
  gem("shoulda-matchers")
end
