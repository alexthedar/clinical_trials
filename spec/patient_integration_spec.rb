require 'spec_helper'

describe 'the patient route', type: :feature do
  it 'will return an error if there are no patients' do
    visit '/patients'
    expect(page).to have_content 'No patients have been added yet add patients'
  end

  it 'will return a list of patients' do
    patient = Patient.create(name: 'John Connor')
    visit '/patients'
    expect(page).to have_content 'John Connor'
  end
end
