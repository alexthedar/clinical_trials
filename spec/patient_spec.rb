require 'spec_helper'

describe(Patient) do
  it { should have_many :visits }
  it { should have_many (:specialists) }
  it { should have_one (:schedule) }
  it { should have_one (:trial)}

  describe 'validations' do
    subject { Patient.new(first_name: 'john', last_name: 'connor') }
    it { should validate_presence_of :last_name }
    it { should validate_uniqueness_of :first_name }
    it { should validate_presence_of :first_name }
    it { should validate_uniqueness_of :last_name }
    end


  describe '#titleize_name' do
    it 'takes a name and turns it to title case' do
      patient = Patient.create(first_name: "john", last_name: "connor")
      expect(patient.name).to(eq("Connor, John"))
    end
  end

  describe '#name' do
    it 'provdes the last and first name of patient' do
      patient = Patient.create(first_name: "john", last_name: "connor")
      expect(patient.name).to(eq("Connor, John"))
    end
  end
end
