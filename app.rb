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
binding.pry
  erb :patient
end

patch '/patients/:id' do
  @patient = Patient.find(params['id'])
  @patient.update(name: params.fetch('name', @patient.name), phone: params.fetch('phone', @patient.phone), email: params.fetch('email', @patient.email), gender: params.fetch('gender', @patient.gender), birthday: params.fetch('birthday', @patient.birthday))
  redirect to "/patients/#{@patient.id}"
end

get '/specialists' do
  @allspecialists = Specialist.all
  @specialists = @allspecialists.order(:last_name)
  erb :specialists
end

get '/specialists/add' do
  erb :specialist_form
end

post '/specialists/add' do
  Specialist.create({first_name: params.fetch('first_name'), last_name: params.fetch('last_name'), phone: params.fetch('phone', email: params.fetch('email'))})
  redirect '/specialists'
end

delete '/specialist/:id' do
  specialist = Specialist.find(params.fetch('id').to_i)
  specialist.delete
  redirect '/specialists'
end



get '/specialists' do
  @allspecialists = Specialist.all
  @specialists = @allspecialists.order(:last_name)
  erb :specialists
end

get '/specialists/add' do
  erb :specialist_form
end

post '/specialists/add' do
  Specialist.create({first_name: params['first_name'], last_name: params['last_name'], phone: params['phone'], email: params['email']})
  redirect '/specialists'
end

delete '/specialist/:id' do
  specialist = Specialist.find(params.fetch('id').to_i)
  specialist.delete
  redirect '/specialists'
end

get '/specialist/:id' do
  @specialist = Specialist.find(params['id'])
  erb :specialist
end

post '/specialist/:id' do
  @specialist = Specialist.find(params.fetch('id'))
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  phone = params.fetch('phone')
  email = params.fetch('email')

  if first_name == ""
    first_name = @specialist.first_name
  end
  if last_name == ""
    last_name = @specialist.last_name
  end
  if phone == ""
    phone = @specialist.phone
  end
  if email == ""
    email = @specialist.email
  end
  @specialist.update({:first_name => first_name, :last_name => last_name, :phone => phone, :email => email})

  redirect '/specialist/'.concat(@specialist.id().to_s())
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

get '/trials' do
  @alltrials = Trial.all
  @trials = @alltrials.order(:name)
  erb :trials
end

get '/trials/add' do
  erb :trial_form
end

post '/trials' do
  Trial.create(company: params['company'], name: params['name'], number_of_visits: params['visits'], description: params['description'])
  redirect '/trials'
end

get '/trials/:id' do
  @trial = Trial.find(params.fetch('id').to_i)
  erb :trial
end

post '/trials/:id' do
  @trial = Trial.find(params.fetch('id'))
  company = params.fetch('company')
  name = params.fetch('name')
  visits = params.fetch('visits')
  description = params.fetch('description')

  if company == ""
    company = @trial.company
  end
  if name == ""
    name = @trial.name
  end
  if visits == ""
    visits = @trial.number_of_visits
  end
  if description == ""
    description = @trial.description
  end
  @trial.update({:company => company, :name => name, :number_of_visits => visits, :description => description})

  redirect '/trials/'.concat(@trial.id().to_s())
end

delete '/trials/:id' do
  trial_id = params.fetch('id').to_i
  trial = Trial.find(trial_id)
  trial.delete
  redirect '/trials'
end
