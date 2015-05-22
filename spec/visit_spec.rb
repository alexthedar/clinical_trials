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
