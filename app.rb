require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

before do
  @patient = Patient.new
  @specialist = Specialist.new
end

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
  patient.update(first_name: params.fetch('first_name'))
  patient.update(last_name: params.fetch('last_name'))
  patient.update(phone: params.fetch('phone'))
  patient.update(email: params.fetch('email'))
  patient.update(gender: params.fetch('gender'))
  patient.update(birthday: params.fetch('birthday'))
  redirect "/patients/#{patient.id}"
end

delete '/patients/:id' do
  patient = Patient.find(params['id'])
  patient.destroy
  redirect to '/patients'
end

get '/specialists' do
  @allspecialists = Specialist.all
  @specialists = @allspecialists.order(last_name: :asc)
  erb :specialists
end

get '/specialists/add' do
  erb :specialist_form
end

post '/specialists/add' do
  Specialist.create(first_name: params['first_name'],last_name: params['last_name'], phone: params['phone'], email: params['email'])
  redirect '/specialists'
end


delete '/specialists/:id' do
  specialist = Specialist.find(params.fetch('id').to_i)
  specialist.delete
  redirect '/specialists'
end

get '/specialists/:id' do
  @specialist = Specialist.find(params['id'])
  @vacations = @specialist.vacations
  erb :specialist
end

patch '/specialist/:id' do
  specialist = Specialist.find(params['id'])
  specialist.update(first_name: params.fetch('first_name'))
  specialist.update(last_name: params.fetch('last_name'))
  specialist.update(phone: params.fetch('phone'))
  specialist.update(email: params.fetch('email'))
  redirect "/specialist/#{specialist.id}"
end

delete '/vacation/delete/:id' do
  @specialist = Specialist.find(params.fetch('specialist_id').to_i)
  vacation = Vacation.find(params.fetch('id').to_i)
  vacation.destroy
  redirect "/specialists/".concat(@specialist.id().to_s())
end

get '/vacation/:id' do
  @specialist = Specialist.find(params.fetch('id'))
  @all_vacay = @specialist.vacations
  @vacations = @all_vacay.order(:start_date)
  erb(:vacation)
end

post '/vacation/add/:id' do
  @specialist = Specialist.find(params.fetch('id').to_i)
  new_vacation = Vacation.create({start_date: params['start_date'], end_date: params['end_date'], specialist_id:['id'] })
  @specialist.vacations.push(new_vacation)
  redirect "/vacation/#{@specialist.id}"
end

delete '/vacation/:id' do
  @specialist = Specialist.find(params.fetch('id').to_i)
  vacation = Vacation.find(params.fetch('vacay_id').to_i)
  vacation.delete
  redirect "/vacation/".concat(@specialist.id().to_s())
end


patch '/vacation/edit/:id' do
  @specialist = Specialist.find(params.fetch('id').to_i)
  vacation = Vacation.find(params['vacay_id'])
  start_date = params.fetch('start_date')
  end_date = params.fetch('end_date')
  vacation.update(start_date: start_date, end_date: end_date, specialist_id: @specialist.id)
  redirect "/vacation/".concat(@specialist.id().to_s())
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
  trial = Trial.create(company: params['company'], name: params['name'], number_of_visits: params['visits'], description: params['description'], start_date: params['start_date'], end_date: params['end_date'])
  trial_calendar = Calendar.new(start_date: trial.start_date, end_date: trial.end_date)
  redirect '/trials'
end

get '/trials/:id' do
  @trial = Trial.find(params.fetch('id').to_i)
  @patients = Patient.all
  @enrolled_patients = Patient.find(@trial.patient_ids.uniq)
  @specialists = Specialist.all
  @assigned_specialists = @trial.specialists
  erb :trial
end

post '/trials/:id/update' do
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

post '/trials/:id/add/patients' do
  trial = Trial.find(params['id'])
  patients = Patient.find(params['patient_ids'])
  patients.each do |patient|
    trial.patients.push(patient)
  end
  redirect to "/trials/#{trial.id}"
end

post '/trials/:id/add/specialists' do
  trial = Trial.find(params['id'])
  specialists = Specialist.find(params['specialist_ids'])
  specialists.each do |specialist|
    trial.specialists.push(specialist)
  end
  redirect to "/trials/#{trial.id}"
end

get '/trials/:id/schedule' do
  @trial = Trial.find(params['id'])
  @schedule_template = @trial.schedules
  erb :schedule
end

get '/trials/:id/schedule/add' do
  @trial = Trial.find(params['id'])
  @schedule_template = @trial.schedules
  erb :schedule_form
end

patch '/trials/:id/schedule/add' do
  @trial = Trial.find(params['id'])
  schedule = Schedule.create(description: params['description'], visit_number: params['visit_number'], days_to_next: params['days_to_next'], trial_id: @trial.id)
  @schedule_template = @trial.schedules
  redirect to "/trials/#{@trial.id}/schedule/add"
end

get '/trials/:trial_id/patient/:patient_id/schedule' do
  @trial = Trial.find(params['trial_id'])
  @schedule_template = @trial.schedules
  @patient = Patient.find(params['patient_id'])
  @visits = @patient.visits
  erb :patient_schedule
end

post '/trials/:trial_id/patient/:patient_id/schedule' do
  @trial = Trial.find(params['trial_id'])
  @schedule_template = @trial.schedules
  @patient = Patient.find(params['patient_id'])
# binding.pry  
  @results = @trial.schedule_patient(@patient, (params['visit_date'].to_date))
  @conflicts = @results[0]
  @visits = @patient.visits
  erb :patient_schedule
end

get '/trial_information_test' do
  erb :trial_information_test
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
