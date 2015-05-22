require 'spec_helper'

describe(Trial) do
  it { should have_many (:visits)}
  it { should have_many (:patients)}
  it { should have_many (:specialists)}
  it { should have_many (:schedules)}
  it('should capitalize the first letter') do
    trial = Trial.create({:name => 'acid test', :company => 'boats n hoes'})
    expect(trial.name).to(eq('Acid Test'))
    expect(trial.company).to(eq('Boats N Hoes'))
  end

  describe '#available_patients' do
    it 'will return a list of patients that are available for enrollment' do
      patient_0 = Patient.create(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
      patient_1 = Patient.create(first_name: "sarah", last_name: "willis", phone: '5551113333')
      patient_2 = Patient.create(first_name: "fred", last_name: "astaire", phone: '1112223333')
      trial_0 = Trial.create({:name => 'acid test', :company => 'boats n hoes'})
      trial_1 = Trial.create({:name => 'boat test', :company => 'acid n hoes'})
      trial_0.patients.push(patient_0)
      trial_1.patients.push(patient_1)
      expect(trial_0.available_patients).to eq [patient_2]
    end
  end

  describe '#schedule_patient' do
    it 'will find conflicts and return them when scheduling a patient' do
      start_date = Date.new(2015,5,15)
      end_date = Date.new(2015,5,26)
      test_date = Date.new(2015, 5, 18)
      trial = Trial.create(name: 'acid test', company: 'boats n hoes', number_of_visits: 3, start_date: start_date, end_date: end_date)
      visit = Visit.create(appt_date: test_date)
      patient = Patient.create(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
      trial.patients.push(patient)
      expect(trial.schedule_patient(patient, test_date)).to eq [[["This patient cannot be scheduled on #{visit.appt_date}", visit.appt_date]], []]
    end

    it 'will return an empty array of conflicts if scheduled correctly' do
      start_date = Date.new(2015,5,15)
      end_date = Date.new(2015,5,26)
      test_date = Date.new(2015, 5, 18)
      good_date = Date.new(2015, 5, 19)
      trial = Trial.create(name: 'acid test', company: 'boats n hoes', number_of_visits: 2, start_date: start_date, end_date: end_date)
      schedule_0 = Schedule.create(description: 'the first visit', visit_number: 1, days_to_next: 3, trial_id: trial.id)
      schedule_1 = Schedule.create(description: 'the second visit', visit_number: 2, days_to_next: 0, trial_id: trial.id)
      conflict_visit = Visit.create(appt_date: test_date)
      patient = Patient.create(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
      trial.patients.push(patient)
      expect(trial.schedule_patient(patient, good_date)).to eq [[], [trial.visits[1], trial.visits[2]]]
    end

    it 'will find conflicts and return them when scheduling a patient, and destroy any scheduled visits' do
      start_date = Date.new(2015,5,15)
      end_date = Date.new(2015,5,26)
      test_date = Date.new(2015, 5, 20)
      good_date = Date.new(2015, 5, 18)
      trial = Trial.create(name: 'acid test', company: 'boats n hoes', number_of_visits: 2, start_date: start_date, end_date: end_date)
      schedule_0 = Schedule.create(description: 'the first visit', visit_number: 1, days_to_next: 2, trial_id: trial.id)
      schedule_1 = Schedule.create(description: 'the second visit', visit_number: 2, days_to_next: 0, trial_id: trial.id)
      conflict_visit = Visit.create(appt_date: test_date)
      patient = Patient.create(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
      trial.patients.push(patient)
      expect(trial.schedule_patient(patient, good_date)).to eq [[["Visit #{schedule_1.visit_number} has a conflict on #{test_date}", test_date]], []]
      expect(trial.visits.length).to eq 1
    end
  end
end
