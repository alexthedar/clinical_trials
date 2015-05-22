require 'spec_helper'

describe(Visit) do
  it { should belong_to (:patient)}
  it { should belong_to (:schedule)}
  it { should belong_to (:specialist)}
  it { should belong_to (:trial)}

  it ('can find visits between two dates') do
    visit = Visit.create(appt_date: Date.new(2015, 1, 12))
    visit1 = Visit.create(appt_date: Date.new(2015, 1, 13))
    visit2 = Visit.create(appt_date: Date.new(2015, 1, 14))
    visit3 = Visit.create(appt_date: Date.new(2015, 1, 15))
    expect(Visit.scheduled_visits(Date.new(2015, 1, 12), Date.new(2015, 1, 14))).to eq [visit, visit1, visit2]
  end

  describe '.scheduled_dates' do
    it 'will return an array of dates that are scheduled' do
      visit = Visit.create(appt_date: Date.new(2015, 1, 12))
      visit1 = Visit.create(appt_date: Date.new(2015, 1, 13))
      visit2 = Visit.create(appt_date: Date.new(2015, 1, 14))
      visit3 = Visit.create(appt_date: Date.new(2015, 1, 15))
      expect(Visit.scheduled_dates(Date.new(2015, 1, 12), Date.new(2015, 1, 14))).to eq [Date.new(2015, 1, 12), Date.new(2015, 1, 13), Date.new(2015, 1, 14)]
    end
  end
end

  # describe 'deletes patient from trial through visit' do
  #   it 'will remove patient from visits table with trial id' do
  #     patient_0 = Patient.create(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
  #     patient_1 = Patient.create(first_name: "sarah", last_name: "willis", phone: '5551113333')
  #     patient_2 = Patient.create(first_name: "fred", last_name: "astaire", phone: '1112223333')
  #     trial = Trial.create({:name => 'acid test', :company => 'boats n hoes'})
  #     visit = Visit.create(appt_date: Date.new(2015, 1, 12), trial_id: trial.id, patient_id: patient_0.id)
  #     visit1 = Visit.create(appt_date: Date.new(2015, 1, 13), trial_id: trial.id, patient_id: patient_0.id)
  #     visit2 = Visit.create(appt_date: Date.new(2015, 1, 14), trial_id: trial.id, patient_id: patient_0.id)
  #     visit3 = Visit.create(appt_date: Date.new(2015, 1, 12), trial_id: trial.id, patient_id: patient_1.id)
  #     visit4 = Visit.create(appt_date: Date.new(2015, 1, 13), trial_id: trial.id, patient_id: patient_1.id)
  #     visit5 = Visit.create(appt_date: Date.new(2015, 1, 14), trial_id: trial.id, patient_id: patient_1.id)
  #     visit3 = Visit.create(appt_date: Date.new(2015, 1, 12), trial_id: trial.id, patient_id: patient_2.id)
  #     visit4 = Visit.create(appt_date: Date.new(2015, 1, 13), trial_id: trial.id, patient_id: patient_2.id)
  #     visit5 = Visit.create(appt_date: Date.new(2015, 1, 14), trial_id: trial.id, patient_id: patient_2.id)
  #     all_visits = trial.visits(patient_0)
  #     patient_0.delete_visits(trial.id)
  #     expect(trial.patients).to eq [patient_1]
  #   end
  # end
