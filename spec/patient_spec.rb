require 'spec_helper'

describe(Patient) do
  it { should have_many :visits }
  it { should have_many (:specialists) }
  it { should have_one (:schedule) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  describe '#titleize_name' do
    it 'takes a name and turns it to title case' do
      patient = Patient.create(name: 'john connor')
      expect(patient.name).to(eq("John Connor"))
    end
  end
end
