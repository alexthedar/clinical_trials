require 'spec_helper'

describe 'the patient route', type: :feature do
  it 'will return an error if there are no patients' do
    visit '/patients'
    expect(page).to have_content 'No patients have been added yet add patients'
  end

  it 'will return a list of patients' do
    patient = Patient.create(first_name: 'John', last_name: 'connor', phone: '(404) 281-3895')
    visit '/patients'
    expect(page).to have_content 'Connor, John'
  end

  it 'will show a page with a specific patients information' do
    patient = Patient.create(first_name: 'John', last_name: 'connor', phone: '(404) 281-3895')
    visit "/patients/#{patient.id}"
    expect(page).to have_content 'Patient Name: Connor, John'
  end

  it 'will update a patient\'s information.' do
    patient = Patient.create(first_name: 'John', last_name: 'connor', phone: '(404) 281-3895')
    visit "/patients/#{patient.id}"
    fill_in :first_name, with: 'Sarah'
    fill_in :last_name, with: 'Ludwig'
    fill_in :phone, with: '(503) 231-5555'
    fill_in :email, with: 'sarah@skynet.org'
    select 'Female', from: :gender
    click_button 'Update'
    expect(page).to have_content 'Patient Name: Ludwig, Sarah'
    expect(page).to have_content '(503) 231-5555'
    expect(page).to have_content 'sarah@skynet.org'
    expect(page).to have_content 'Female'
  end
end
