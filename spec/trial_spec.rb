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
end
