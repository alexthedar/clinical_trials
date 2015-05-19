ENV['RACK_ENV'] = 'test'


require("bundler/setup")
Bundler.require(:default, :test, :production)

set(:root, Dir.pwd())

# require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Trial.all.each do |trial|
      trial.destroy
    end
    Schedule.all.each do |sch|
      sch.destroy
    end
    Patient.all.each do |pat|
      pat.destroy
    end
    Specialist.all.each do |special|
      special.destroy
    end
    Visit.all.each do |visit|
      visit.destroy
    end
    Vacation.all.each do |v|
      v.destroy
    end
  end
  config.before(:each) do
    Trial.all.each do |trial|
      trial.destroy
    end
    Schedule.all.each do |sch|
      sch.destroy
    end
    Patient.all.each do |pat|
      pat.destroy
    end
    Specialist.all.each do |special|
      special.destroy
    end
    Visit.all.each do |visit|
      visit.destroy
    end
    Vacation.all.each do |v|
      v.destroy
    end
  end
end
