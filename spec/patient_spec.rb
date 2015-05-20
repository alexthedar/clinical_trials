require 'spec_helper'

describe(Patient) do
  it { should have_many :visits }
  it { should have_many (:specialists) }
  it { should have_one (:schedule) }
  it { should have_one (:trial)}

  describe 'validations' do
    subject { Patient.create(first_name: 'john', last_name: 'connor', phone: '(555) 555-5555') }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :first_name }
    it { should validate_length_of(:phone).is_equal_to 10 }
  end

  describe '#titleize_name' do
    it 'takes a name and turns it to title case' do
      patient = Patient.create(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
      expect(patient.name).to(eq("Connor, John"))
    end
  end

  describe '#name' do
    it 'provdes the last and first name of patient' do
      patient = Patient.create(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
      expect(patient.name).to(eq("Connor, John"))
    end
  end

  describe '#strip_number' do
    it 'removes spaces, parens, and hyphens from a phone number string' do
      patient = Patient.new(first_name: "john", last_name: "connor", phone: '(404) 281-3895')
      patient.strip_number
      expect(patient.phone).to eq '4042813895'
    end
  end

  describe '#convert_number' do
    it 'converts a string of numbers to a phone number' do
      patient = Patient.new(first_name: "john", last_name: "connor", phone: '4042813895')
      patient.convert_number
      expect(patient.phone).to eq '(404) 281-3895'
    end
  end
end
