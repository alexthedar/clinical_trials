require 'bundler/setup'
Bundler.require :default








get '/' do

  erb(:index)
end

get '/patients' do

  erb(:patients)
end

get '/patients/add' do

  erb(:patient_form)
end

get '/events/export/events.ics' do
  cal = Icalendar::Calendar.new
  cal.event do |e|
    e.dtstart     = Icalendar::Values::Date.new('20050428')
    e.dtend       = Icalendar::Values::Date.new('20050429')
    e.summary     = "Meeting with the man."
    e.description = "Have a long lunch meeting and decide nothing..."
    e.ip_class    = "PRIVATE"
  end
  cal.event do |e|
    e.dtstart     = Icalendar::Values::Date.new('20150428')
    e.dtend       = Icalendar::Values::Date.new('20150429')
    e.summary     = "Meeting with the other man."
    e.description = "Have a short lunch meeting and decide nothing..."
    e.ip_class    = "PRIVATE"
  end
  cal.event do |e|
    e.dtstart     = Icalendar::Values::Date.new('20150428')
    e.dtend       = Icalendar::Values::Date.new('20150429')
    e.summary     = "Fix Calendar."
    e.description = "Have a short lunch meeting and decide nothing..."
    e.ip_class    = "PRIVATE"
  end
  cal.publish
  Dir[File.dirname(__FILE__) + '/views/events.ics'].each do |file|
    output = File.open( file, "w" )
    output << cal.to_ical
    output.close
  end
  File.read File.dirname(__FILE__) + '/views/events.ics'
end
