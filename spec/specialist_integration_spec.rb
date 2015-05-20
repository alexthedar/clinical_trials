require 'spec_helper'

describe 'the specialist route', type: :feature do
  it 'will return an error if there are no patients' do
    visit '/specialists'
    expect(page).to have_content 'No specialists have been added'
  end

  it 'will return a list of patients' do
    specialist = Specialist.create(first_name: 'John', last_name: 'Digweed', phone: '(404) 281-3895', email: 'john@johndigweed.com')
    visit '/patients'
    expect(page).to have_content 'Connor, John'
  end

  it 'will show a page with a specific patients information' do
    specialist = Specialist.create(first_name: 'John', last_name: 'Digweed', phone: '(404) 281-3895', email: 'john@johndigweed.com')
    visit "/specialist/#{specialist.id}"
    expect(page).to have_content 'Name: Connor, John'
  end

  it 'will update a patient\'s information.' do
    specialist = Specialist.create(first_name: 'John', last_name: 'Digweed', phone: '(404) 281-3895', email: 'john@johndigweed.com')
    visit "/specialist/#{specialist.id}"
    fill_in :first_name, with: 'Markus'
    fill_in :last_name, with: 'Schulz'
    fill_in :phone, with: '(503) 231-5555'
    fill_in :email, with: 'markus@markusschulz.com'
    click_button 'Update'
    expect(page).to have_content 'Name: Schulz, Markus'
    expect(page).to have_content '(503) 231-5555'
    expect(page).to have_content 'markus@markusschulz.com'
  end
end
