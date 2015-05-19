require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do

  erb(:index)
end

get '/patients' do
  @patients = Patient.all
  erb(:patients)
end

post '/patients' do
  Patient.create(name: params['name'], phone: params['phone'], email: params['email'], gender: params['gender'], birthday: params['birthday'])
  redirect to '/patients'
end

get '/patients/add' do

  erb(:patient_form)
end


get '/patients/:id' do
  @patient = Patient.find(params['id'])
  erb(:patient)
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


get '/specialists' do
  @allspecialists = Specialist.all
  @specialists = @allspecialists.order(:name)
  erb(:specialists)
end

post 'specialist/:id' do
  Specialist.create({name: params.fetch('name'), phone: params.fetch('phone', email: params.fetch('email'))})
  erb(:specialist)
end

delete '/specialist/:id' do
  specialist = Special.find(params.fetch.('id').to_i)
  specialist.delete
  redirect('/specialists')
end

patch '/specialist/:id' do
  special_id = params.fetch.('id').to_i
  specialist = Special.find(special_id)
  if params[:new_name]
    name = params.fetch.('new_name')
    if name != ""
      specialist.update({name: name})
    end
  if params[:new_phone]
    phone = params.fetch.('new_phone')
    if phone != ""
      specialist.update(phone: phone)
    end
  if params[:new_email]
    email = params.fetch.('new_email')
    if email != ""
      specialist.update('new_email')
    end
  end
  redirect('specilists')
end
