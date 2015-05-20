require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  erb :index
end

get '/patients' do
  @patients = Patient.all
  erb :patients
end

post '/patients' do
  Patient.create(first_name: params['first_name'],last_name: params['last_name'], phone: params['phone'], email: params['email'], gender: params['gender'], birthday: params['birthday'])
  redirect to '/patients'
end

get '/patients/add' do

  erb :patient_form
end


get '/patients/:id' do
  @patient = Patient.find(params['id'])
  erb :patient
end

patch '/patients/:id' do
  patient = Patient.find(params['id'])
  patient.update(first_name: params.fetch('first_name', patient.first_name), last_name: params.fetch('last_name', patient.last_name), phone: params.fetch('phone', patient.phone), email: params.fetch('email', patient.email), gender: params.fetch('gender', patient.gender), birthday: params.fetch('birthday', patient.birthday))
  redirect "/patients/#{patient.id}"
end

get '/specialists' do
  @allspecialists = Specialist.all
  @specialists = @allspecialists.order(:name)
  erb :specialists
end

get '/specialists/add' do
  erb :specialist_form
end

post '/specialists/add' do
  Specialist.create({name: params.fetch('name'), phone: params.fetch('phone', email: params.fetch('email'))})
  redirect '/specialists'
end

delete '/specialist/:id' do
  specialist = Specialist.find(params.fetch('id').to_i)
  specialist.delete
  redirect '/specialists'
end

patch '/specialist/:id' do
  special_id = params.fetch('id').to_i
  specialist = Special.find(special_id)
  name = params.fetch.('new_name', specialist.name)
  phone = params.fetch.('new_phone', specialist.phone)
  email = params.fetch.('new_email', specialist.email)
  specialist.update(name: 'new_name', phone: 'new_phone', email: 'new_email')
  redirect '/specialists'
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
