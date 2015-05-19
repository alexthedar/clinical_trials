require 'spec_helper'

describe(Specialist) do
  it { should have_many (:visits)}
  it { should have_many (:vacations)}
  it { should have_many (:patients)}
  it { should have_many (:trials)}
  it { should validate_presence_of(:name)}
  it('should capitalize the first letter') do
    person = Specialist.create({:name => 'bob smith'})
    expect(person.name).to(eq('Bob Smith'))
  end
end
